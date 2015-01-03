# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "Supercomputador"
    description "Proyecto lorem ipsum aenum proyectus"
    estimated_budget "135.99"
    is_strategic false
    status 1
  end
end
