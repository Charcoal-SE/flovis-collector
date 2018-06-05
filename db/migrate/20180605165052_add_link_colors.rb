# frozen_string_literal: true

require 'active_record/migration'

class AddLinkColors < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :link_color, :string
  end
end
