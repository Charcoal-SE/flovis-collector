# frozen_string_literal: true

require_relative 'application_record'

class Post < ApplicationRecord
  belongs_to :site
  has_many :stages
end
