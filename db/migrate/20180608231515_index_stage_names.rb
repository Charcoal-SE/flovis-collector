# frozen_string_literal: true

require 'active_record/migration'

class IndexStageNames < ActiveRecord::Migration[5.2]
  def change
    add_index :stages, :name
  end
end
