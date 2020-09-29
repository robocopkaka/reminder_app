# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com",
  password: "password"
)

validation_rules = [
  {"validations"=>{"day_of_week"=>{"0"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"1"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"2"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"3"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"4"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"5"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"6"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"6"=>[2]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"6"=>[3]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
  {"validations"=>{"day_of_week"=>{"6"=>[1]}}, "rule_type"=>"IceCube::MonthlyRule", "interval"=>1},
]

days = [
  "Monthly on the 1st Sunday",
  "Monthly on the 1st Monday",
  "Monthly on the 1st Tuesday",
  "Monthly on the 1st Wednesday",
  "Monthly on the 1st Thursday",
  "Monthly on the 1st Friday",
  "Monthly on the 1st Saturday",
  "Monthly on the 2nd Saturday",
  "Monthly on the 3rd Saturday",
  "Monthly on the last Saturday",
]

20.times do |number|
  Reminder.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    time: Time.current,
    validation_rules: validation_rules[number % 10],
    day: days[number % 10],
    user_id: user.id
  )
end
