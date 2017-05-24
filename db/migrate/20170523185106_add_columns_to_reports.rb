class AddColumnsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :printable, :boolean, null: false, default: false, after: :active
    add_column :reports, :exportable, :boolean, null: false, default: false, after: :printable
  end
end
