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

10.times do
  User.create(
    name: Faker::FunnyName.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8) 
  )
end

5.times do
  Category.create(
    title: Faker::Superhero.power
  )
end

20.times do
  Equipment.create(
    name: Faker::Construction.heavy_equipment,
    description: Faker::ChuckNorris.fact,
    user_id: Faker::Number.between(from: 1, to: 10)
  )
end