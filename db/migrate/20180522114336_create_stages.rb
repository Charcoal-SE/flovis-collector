# frozen_string_literal: true

require 'active_record/migration'

class CreateStages < ActiveRecord::Migration[5.2]
  def change
    create_table :stages do |t|
      t.string :name, null: false
      t.references :post, index: true, foreign_key: true, null: false
      t.text :data

      t.timestamps
    end
  end
end
