FactoryBot.define do
  factory :reminder do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    time { Time.current }
    day { "Monthly on the first sunday" }
    validation_rules {
        {"validations"=>{"day_of_week"=>{"0"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1}
    }
    user_id { 1 }
  end
end
