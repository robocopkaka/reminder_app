class RemindersController < ApplicationController
  before_action :require_login
  def new
    @reminder = Reminder.new
  end
  
  def create
    @reminder = current_user.reminders.new(reminder_params)
    parse_schedule(reminder_params[:day])
    if @reminder.save
      redirect_to root_path
    else
      render "new"
    end
  end
  
  private
  
  def reminder_params
    params.require(:reminder).permit(
      :title,
      :description,
      :time,
      :day,
      :reminder
    )
  end
  
  def parse_schedule(schedule)
    begin
      validations = JSON.parse(schedule)
      rule = RecurringSelect.dirty_hash_to_rule(validations)
      @reminder.day = rule.to_s
      @reminder.validation_rules = validations
    rescue JSON::ParserError
     @reminder.day = ""
    end
  end
end
