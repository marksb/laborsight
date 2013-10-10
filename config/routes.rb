DolChallenge::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  get '/companies/data', to: 'companies#data', as: 'companies_data'
  get '/companies/neighborhood', to: 'companies#neighborhood', as: 'companies_neighborhood'
  get '/companies/:id', to: 'companies#show', as: 'companies'
  get '/companies/:id/chart_industry', to: 'companies#chart_industry', as: 'chart_industry'
  get '/companies/:id/chart_local', to: 'companies#chart_local', as: 'chart_local'
  get '/companies/:id/chart_national', to: 'companies#chart_national', as: 'chart_national'
  root to: "maps#index"
end
