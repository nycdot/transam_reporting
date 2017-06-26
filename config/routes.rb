Rails.application.routes.draw do
  get 'reports/:id/details' => 'reporting_reports#details'
  get 'reports/:id'  => 'reporting_reports#show'
end
