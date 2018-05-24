# frozen_string_literal: true

require 'active_record/migration'

class SetCollationTypes < ActiveRecord::Migration[5.2]
  def change
    change_table :stages, options: 'CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci' do |_t|; end
    change_column :stages, :data, 'TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci'
  end
end
