class MakeSystemReportsNotExportable < ActiveRecord::DataMigration
  def up
    reports = [
        {
            :name => 'User Login Report'
        },
        {
            :name => 'Issues Report'
        }
    ]

    reports.each do |report|
      Report.find_by(report).update!(printable: true, exportable: false)

    end
  end
end