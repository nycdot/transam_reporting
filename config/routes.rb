Rails.application.routes.draw do
  get 'reports/:id/details' => 'reporting_reports#details'
  get 'reports/:id/export_data' => 'reporting_reports#export_data', as: 'export_data_report'
  get 'reports/:id'  => 'reporting_reports#show'
end
