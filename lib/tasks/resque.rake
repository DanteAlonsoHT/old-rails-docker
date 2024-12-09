namespace :resque do
  task :setup => :environment do
    # Carga solo los modelos y workers
    Dir[Rails.root.join('app/models/**/*.rb')].each { |file| require file }
    Dir[Rails.root.join('app/workers/**/*.rb')].each { |file| require file }
  end
end
