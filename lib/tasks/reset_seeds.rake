namespace :db do
  desc 'Reset database to a clean state and reapply seeds'
  task reset: :environment do
    puts 'Resetting database...'
    AuditLog.delete_all
    Purchase.delete_all
    ProductImage.delete_all
    ProductCategory.delete_all
    Category.delete_all
    Product.delete_all
    Customer.delete_all
    Administrator.delete_all
    puts 'Database cleared!'
  end
end
