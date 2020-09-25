class RemindersController < ApplicationController
  def new
    @reminder = Reminder.new
  end
  
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder = parse_schedule(@reminder, reminder_params[:day])
    if @reminder.save
      redirect_to root_path
    else
      render :new
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
  
  def parse_schedule(obj, schedule)
    validations = JSON.parse(schedule)["validations"]
    day = validations["day_of_month"]
    obj.day = day
    obj
  end
end
