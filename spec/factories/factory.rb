FactoryGirl.define do
  factory :user do

    sequence (:email) { |n| "email#{n}@factory.com" }
    sequence (:username) { |n| "JohnDoe#{n}" }

    first_name 'John'
    last_name 'Doe'
    password 'password'
    default_city 'Chicago'
    default_state 'IL'
  end

end
