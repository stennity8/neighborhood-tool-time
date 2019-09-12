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

20.times do
  Equipment.create(
    name: Faker::Construction.heavy_equipment,
    description: Faker::ChuckNorris.fact,
    user_id: Faker::Number.between(from: 1, to: 12),
    pic_url: Faker::Avatar.image
  )
end

50.times do
  Borrow.create(
    user_id: Faker::Number.between(from: 1, to: 10),
    equipment_id: Faker::Number.between(from: 1, to: 20),
    start_time: Faker::Time.between_dates(from: DateTime.now, to: DateTime.now + Faker::Number.between(from: 1, to: 7), period: :all),
    end_time: Faker::Time.between_dates(from: DateTime.now, to: DateTime.now + Faker::Number.between(from: 1, to: 7), period: :all)
  )
end

Equipment.all.each do |equipment|
  2.times do
    equipment.categories << Category.find(Faker::Number.between(from: 1, to: 10))
  end
end