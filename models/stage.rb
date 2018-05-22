# frozen_string_literal: true

require_relative 'application_record'

class Stage < ApplicationRecord
  belongs_to :post

  serialize :data, JSON
end
