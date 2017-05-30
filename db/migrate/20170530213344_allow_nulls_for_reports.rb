class AllowNullsForReports < ActiveRecord::Migration
  def change
    change_column :reports, :printable, :boolean, null: true
    change_column :reports, :exportable, :boolean, null: true
  end
end
