# frozen_string_literal: true

require 'json'
require 'date'
require 'eventmachine'
require 'faye/websocket'
require 'rack'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/numeric/time'

Faye::WebSocket.load_adapter('thin')

@clients = {}

Server = Rack::Builder.new do
  app = ->(env) do
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)
      @clients[ws] = DateTime.now

      pings = EM.add_periodic_timer(10) do
        if @clients[ws] < 60.seconds.ago
          ws.close(4000, 'Ping timeout')
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
    ws.close(4001, 'Non-JSON data received')
    closed = true
  end

  return if closed || msg['action'].blank?
  case msg['action']
  when 'pong'
    @clients[ws] = DateTime.now
  else
    ws.send(JSON.dump(action: 'info', message: "unrecognized action #{msg['action']}"))
  end
end
