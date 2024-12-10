# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ENV['SKIP_EMAILS'] = 'true'
Category.audit_enabled = false
Product.audit_enabled = false

AuditLog.delete_all
Purchase.delete_all
ProductImage.delete_all
ProductCategory.delete_all
Category.delete_all
Product.delete_all
Customer.delete_all
Administrator.delete_all

puts 'Creating administrators...'
admins = []
5.times do |i|
  admin = Administrator.new(
    email: "admin#{i + 1}@example.com",
    name: "Admin #{i + 1}"
  )
  admin.password = 'password'
  admin.save!
  admins << admin
end

puts 'Creating categories...'
categories = []
10.times do |i|
  creator = admins.sample
  updater = admins.sample
  categories << Category.create!(
    name: "Category #{i + 1}",
    created_by_id: creator.id,
    updated_by_id: updater.id
  )
end

puts 'Creating products...'
products = []
25.times do |i|
  creator = admins.sample
  updater = admins.sample
  product = Product.create!(
    name: "Product #{i + 1}",
    description: "This is a description for product #{i + 1}.",
    price: rand(100..1000).to_f,
    created_by_id: creator.id,
    updated_by_id: updater.id
  )

  # Asociar aleatoriamente de 2 a 3 categorías
  categories.sample(rand(2..3)).each do |category|
    ProductCategory.create!(product_id: product.id, category_id: category.id)
  end
  products << product
end

puts 'Creating product images...'
products.each do |product|
  rand(1..3).times do |i|
    ProductImage.create!(
      product_id: product.id,
      image_url: "https://example.com/product#{product.id}_image#{i + 1}.jpg"
    )
  end
end

puts 'Creating customers...'
customers = []
20.times do |i|
  customers << Customer.create!(
    name: "Customer #{i + 1}",
    email: "customer#{i + 1}@example.com"
  )
end

puts 'Creating purchases...'
customers.each do |customer|
  rand(1..10).times do
    product = products.sample
    Purchase.create!(
      product_id: product.id,
      customer_id: customer.id,
      price_at_sale: product.price,
      purchased_at: Time.now - rand(1..30).days
    )
  end
end

puts 'Creating audit logs...'
products.each do |product|
  admin = admins.sample
  AuditLog.create!(
    auditable_type: 'Product',
    auditable_id: product.id,
    administrator_id: admin.id,
    change_data: "Product '#{product.name}' was updated by #{admin.name}."
  )
end

Category.audit_enabled = true
Product.audit_enabled = true
ENV['SKIP_EMAILS'] = 'false'

puts 'Seeding completed successfully!'
