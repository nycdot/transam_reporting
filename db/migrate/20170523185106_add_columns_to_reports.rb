class AddColumnsToReports < ActiveRecord::Migration[4.2]
  def change
    add_column :reports, :printable, :boolean, null: false, after: :active
    add_column :reports, :exportable, :boolean, null: false, after: :printable
  end
end
