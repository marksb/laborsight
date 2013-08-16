DolChallenge::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  get '/companies/:id', to: 'companies#show', as: 'companies'
end
