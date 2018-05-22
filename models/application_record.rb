# frozen_string_literal: true

require 'yaml'
require 'active_record'

config = YAML.safe_load('../config/database.yml')
ActiveRecord::Base.establish_connection(config)

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
