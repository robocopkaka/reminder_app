# frozen_string_literal: true

# User model
class User < ApplicationRecord
  include Clearance::User
  
  has_many :reminders

  default_scope { includes(:reminders) }

  
  validates_presence_of :email
  validates_uniqueness_of :email, { case_sensitive: false }
end
