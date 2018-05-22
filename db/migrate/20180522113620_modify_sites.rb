# frozen_string_literal: true

require 'active_record/migration'

class ModifySites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :is_child_meta, :boolean, null: false, default: false
    add_column :sites, :api_parameter, :string, null: false
  end
end
