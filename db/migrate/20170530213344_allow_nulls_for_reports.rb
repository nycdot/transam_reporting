class AllowNullsForReports < ActiveRecord::Migration[4.2]
  def change
    change_column :reports, :printable, :boolean, null: true
    change_column :reports, :exportable, :boolean, null: true
  end
end
