# frozen_string_literal: true

require 'active_record/migration'

class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :name, null: false
      t.string :domain, null: false
      t.string :url, null: false
      t.string :icon_url, null: false

      t.timestamps
    end
  end
end
