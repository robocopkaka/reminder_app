class Reminder < ApplicationRecord
  attr_reader :day_selector
  belongs_to :user
  validates_presence_of :title, :time, :day
  
  before_save :set_next_scheduled_at
  
  def set_next_scheduled_at
    ice_cube_rule = IceCube::Rule.from_hash(validation_rules)
    schedule = IceCube::Schedule.new(now = Time.now) do |s|
      s.add_recurrence_rule(ice_cube_rule)
      s.add_exception_time(now)
    end
    next_time = schedule.occurrences(Time.current + 2.months).first
    combined_time = "#{next_time.strftime("%F")} #{time.strftime("%T")}"
    self.next_scheduled_at = Time.zone.parse(combined_time)
  end
  
  ICECUBE_RULES = {
    sunday: [
      nil,
      IceCube::Rule.monthly.day_of_week(sunday: [1]),
      IceCube::Rule.monthly.day_of_week(sunday: [2]),
      IceCube::Rule.monthly.day_of_week(sunday: [3]),
      IceCube::Rule.monthly.day_of_week(sunday: [-2]),
      IceCube::Rule.monthly.day_of_week(sunday: [-1]),
    ],
    monday: [
      nil,
      IceCube::Rule.monthly.day_of_week(monday: [1]),
      IceCube::Rule.monthly.day_of_week(monday: [2]),
      IceCube::Rule.monthly.day_of_week(monday: [3]),
      IceCube::Rule.monthly.day_of_week(monday: [-2]),
      IceCube::Rule.monthly.day_of_week(monday: [-1]),
    ],
    tuesday: [
      nil,
      IceCube::Rule.monthly.day_of_week(tuesday: [1]),
      IceCube::Rule.monthly.day_of_week(tuesday: [2]),
      IceCube::Rule.monthly.day_of_week(tuesday: [3]),
      IceCube::Rule.monthly.day_of_week(tuesday: [-2]),
      IceCube::Rule.monthly.day_of_week(tuesday: [-1])
    ],
    wednesday: [
      nil,
      IceCube::Rule.monthly.day_of_week(wednesday: [1]),
      IceCube::Rule.monthly.day_of_week(wednesday: [2]),
      IceCube::Rule.monthly.day_of_week(wednesday: [3]),
      IceCube::Rule.monthly.day_of_week(wednesday: [-2]),
      IceCube::Rule.monthly.day_of_week(wednesday: [-1])
    ],
    thursday: [
      nil,
      IceCube::Rule.monthly.day_of_week(thursday: [1]),
      IceCube::Rule.monthly.day_of_week(thursday: [2]),
      IceCube::Rule.monthly.day_of_week(thursday: [3]),
      IceCube::Rule.monthly.day_of_week(thursday: [-2]),
      IceCube::Rule.monthly.day_of_week(thursday: [-1])
    ],
    friday: [
      nil,
      IceCube::Rule.monthly.day_of_week(friday: [1]),
      IceCube::Rule.monthly.day_of_week(friday: [2]),
      IceCube::Rule.monthly.day_of_week(friday: [3]),
      IceCube::Rule.monthly.day_of_week(friday: [-2]),
      IceCube::Rule.monthly.day_of_week(friday: [-1])
    ],
    saturday: [
      nil,
      IceCube::Rule.monthly.day_of_week(saturday: [1]),
      IceCube::Rule.monthly.day_of_week(saturday: [2]),
      IceCube::Rule.monthly.day_of_week(saturday: [3]),
      IceCube::Rule.monthly.day_of_week(saturday: [-2]),
      IceCube::Rule.monthly.day_of_week(saturday: [-1])
    ],
  }.freeze
end
