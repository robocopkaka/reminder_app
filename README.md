# README

## Prerequisites

* Rails - 6.0.3.3
* Ruby - 2.5.3
* Postgresql 12
* Sidekiq
* Redis
* Install `mailcatcher` with `gem install mailcatcher`

## Installation Steps
* After copying this project onto your system, `cd` into this folder
* Run `rails credentials:edit`
* Add a key  - `db_user` and a value representing your database username
* Add a key - `db_password` and a value representing your database password
* Save your new credentials
* Run  `rails db:create` to create the database
* Run `rails db:migrate` to create all the  necessary tables. 
* Alternatively, you can run `rails schema:load`
* Run `rails db:seed` to seed the database with initial values
* Start the app by running `rails s`

## Tests
* Run `rspec` to run all the tests
* Run `open coverage/index.html` to show the coverage report

## Mails
* To view mails, run `mailcatcher` in a terminal
* Then go to `http://localhost:1080` to view mails

## Cron
* I used `whenever` to create a job that runs daily
* Run `bundle exec wheneverize` to write to your local crontab
* The cron job calls a Rake task - `reminders:queue` to queue up reminders that haven't been scheduled yet
* To test this without waiting for the cron job to run,
  * Create a reminder
  * Run `rake reminders:queue`
  * Go to `http://localhost:3000/sidekiq`
  * You should see that a job has been enqueued

## Recurring reminder logic
I added a `scheduled` column to `reminders` which defaults to `false`.
When the cron job is run, it looks for reminders whose `scheduled` value is false
and then enqueues them using jobs/send_email_reminder_job.rb

It's enqueued using the time in the `next_scheduled_at` column. When the job
for sending email reminders is executed,
`next_scheduled_at` is updated with the date and time it should run for the next month 
and `scheduled` is set to false so it can be picked up by the cron job on it's next run.
  
