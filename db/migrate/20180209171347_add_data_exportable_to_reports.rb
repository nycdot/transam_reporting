class AddDataExportableToReports < ActiveRecord::Migration
  def change
    add_column :reports, :data_exportable, :boolean, after: :exportable
  end
end
