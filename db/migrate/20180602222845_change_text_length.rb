# frozen_string_literal: true

require 'active_record/migration'

class ChangeTextLength < ActiveRecord::Migration[5.2]
  def change
    change_column :stages, :data, 'LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci'
  end
end
