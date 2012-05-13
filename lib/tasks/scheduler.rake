desc "This task is called by the Heroku cron add-on"
task :call_page => :environment do
  uri = URI.parse('http://furious-summer-1580.herokuapp.com/')
  Net::HTTP.get(uri)
end