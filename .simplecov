SimpleCov.start 'rails' do
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Workers", "app/workers"
  add_group "Mailers", "app/mailers"
  add_group "Jobs", "app/jobs"
end
