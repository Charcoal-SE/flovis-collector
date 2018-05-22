# frozen_string_literal: true

require_relative 'application_record'

class Site < ApplicationRecord
  has_many :posts
end
