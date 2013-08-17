DolChallenge::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  get '/companies/data', to: 'companies#data', as: 'companies_data'
  get '/companies/:id', to: 'companies#show', as: 'companies'

  root to: "maps#index"

end
