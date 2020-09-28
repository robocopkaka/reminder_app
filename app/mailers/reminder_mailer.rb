# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  def send_reminder
    @email = params[:email]
    @title = params[:title]
    @description = params[:description]
    @day = params[:day]
    @time = params[:time]
    
    mail to: @email, subject: "#{@title}"
  end
end
