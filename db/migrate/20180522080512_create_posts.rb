# frozen_string_literal: true

require 'active_record/migration'

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.bigint :native_id, null: false
      t.references :site, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
