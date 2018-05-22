# frozen_string_literal: true

require 'json'
require 'yaml'
require 'date'

require 'eventmachine'
require 'faye/websocket'
require 'rack'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/numeric/time'
require 'active_record'

require_relative 'config/socket_codes'
require_relative 'models/post'
require_relative 'models/site'
require_relative 'models/stage'

Faye::WebSocket.load_adapter('thin')

config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(config['development'])

CLIENTS = {}.freeze

Server = Rack::Builder.new do
  app = ->(env) do
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)
      CLIENTS[ws] ||= DateTime.now

      pings = EM.add_periodic_timer(10) do
        if CLIENTS[ws] < 60.seconds.ago
          ws.close(SocketCodes::PING_PONG_TIMEOUT, 'Ping timeout')
        else
          ws.send(JSON.dump(action: 'ping'))
        end
      end

      ws.on :message do |event|
        on_message(ws, event)
      end

      ws.on :close do |_e|
        EM.cancel_timer(pings)
      end

      ws.rack_response
    else
      [200, { 'Content-Type' => 'text/plain' }, ['Shhhhhhh.']]
    end
  end

  run app
end.to_app

def on_message(ws, event)
  begin
    msg = JSON.parse event.data
    closed = false
  rescue
    ws.close(SocketCodes::INVALID_DATA_FORMAT, 'Non-JSON data received')
    closed = true
  end

  return if closed || msg['action'].blank?
  case msg['action']
  when 'pong'
    CLIENTS[ws] = DateTime.now
  when 'stage'
    event_id = msg['event_id']
    success, code, message = create_stage msg
    data = JSON.dump(action: 'response', source: msg, event_id: event_id, success: success, code: code, message: message)
    ws.send(data)
  else
    ws.send(JSON.dump(action: 'info', message: "unrecognized action #{msg['action']}"))
  end
end

def create_stage(data)
  site = Site.find_by domain: data['site']
  return [false, SocketCodes::NONEXISTENT_SITE, "Unrecognised site #{data['site']}"] if site.nil?

  post = Post.find_or_create_by site_id: site.id, native_id: data['post_id']
  stage = Stage.create post: post, name: data['name'], data: data['data']
  [true, SocketCodes::SUCCESS, { post: post.as_json, stage: stage.as_json }]
end
