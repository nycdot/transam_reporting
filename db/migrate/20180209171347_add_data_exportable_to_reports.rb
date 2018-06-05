class AddDataExportableToReports < ActiveRecord::Migration[4.2]
  def change
    add_column :reports, :data_exportable, :boolean, after: :exportable
  end
end
