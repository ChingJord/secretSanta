require 'faker'

FactoryGirl.define do

  factory :member do |m|
  	m.id { Faker::Number.digit }
    m.name { Faker::Name.name }
    m.partner { Faker::Name.name }
    m.last_assigned { Faker::Name.name }
  end

end
