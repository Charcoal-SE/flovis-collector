# frozen_string_literal: true

require 'active_record'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
