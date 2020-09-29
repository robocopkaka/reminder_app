class RemindersController < ApplicationController
  before_action :require_login
  before_action :find_reminder, only: :destroy
  def new
    @reminder = Reminder.new
  end
  
  def create
    @reminder = current_user.reminders.new(reminder_params)
    parse_schedule(reminder_params[:day])
    if @reminder.save
      redirect_to reminders_path
    else
      render "new"
    end
  end
  
  def index
    # using a scope to eager load reminders here
    @reminders = User
                   .where(id: current_user.id)
                   .first
                   .reminders
                   .paginate(per_page: 10, page: params[:page])
  end
  
  def destroy
    @reminder.destroy
    redirect_to reminders_path
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
  
  def find_reminder
    @reminder = Reminder.find_by(id: params[:id])
  end
end
