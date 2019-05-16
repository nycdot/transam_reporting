#encoding: utf-8

# determine if we are using postgres or mysql
is_mysql = (ActiveRecord::Base.configurations[Rails.env]['adapter'].include?'mysql2')
is_sqlite =  (ActiveRecord::Base.configurations[Rails.env]['adapter'] == 'sqlite3')

puts "======= Updating TransAM CORE Reports  ======="

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