# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Equipment.destroy_all
Category.destroy_all
Borrow.destroy_all
EquipmentCategory.destroy_all

User.create(
  name: "Chuck Gato",
  email: "chuck@chuck.com",
  password: "password" 
)

User.create(
  name: "Tucker Gato",
  email: "tuck@tuck.com",
  password: "password" 
)

10.times do
  User.create(
    name: Faker::FunnyName.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8) 
  )
end

10.times do
  Category.create(
    title: Faker::Superhero.power
  )
end

30.times do
  Equipment.create(
    name: Faker::Commerce.product_name,
    description: Faker::TvShows::MichaelScott.quote,
    user_id: Faker::Number.between(from: 1, to: 12),
    pic_url: Faker::Avatar.image,
    brand: Faker::TvShows::GameOfThrones.house
  )
end

100.times do
  loop do
    @num = Faker::Number.between(from: 1, to: 10)
    @num2 = Faker::Number.between(from: 1, to: 30)
    if User.find(@num).owned_equipments.includes(user_id: 1)
      break
    end
  end

  @start = Faker::Time.between_dates(from: DateTime.now - Faker::Number.between(from: 0, to: 7), to: DateTime.now + Faker::Number.between(from: 1, to: 7), period: :all)
  
  Borrow.create(
    user_id: @num,
    equipment_id: @num2,
    start_time: @start,
    end_time: Faker::Time.between_dates(from: @start, to: DateTime.now + Faker::Number.between(from: 2, to: 7), period: :all)
  )
  Equipment.find(@num2).update(available: false)
end

Equipment.all.each do |equipment|
  2.times do
    equipment.categories << Category.find(Faker::Number.between(from: 1, to: 10))
  end
end