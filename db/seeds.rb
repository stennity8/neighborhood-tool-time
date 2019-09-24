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

def user_equip
  @num = Faker::Number.between(from: 1, to: 12)
  @num2 = Faker::Number.between(from: 1, to: 30)
  if User.find(@num).owned_equipments.collect{|e| e.id}.include?(@num2)
    user_equip
  end
end

def add_category(e)
  category = Category.find(Faker::Number.between(from: 1, to: 10))
  if e.categories.include?(category)
    add_category(e)
  else
    return e.categories << category
  end
end

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
  e = Equipment.create(
      name: Faker::Commerce.product_name,
      description: Faker::ChuckNorris.fact,
      user_id: Faker::Number.between(from: 1, to: 12),
      pic_url: Faker::Avatar.image,
      brand: Faker::TvShows::GameOfThrones.house
      )
    
    (Faker::Number.between(from: 1, to: 3)).times do
      add_category(e)
    end

  e.save
end

100.times do
    user_equip

  @start = Faker::Time.between_dates(from: Date.current - Faker::Number.between(from: 0, to: 7), to: Date.current + Faker::Number.between(from: 1, to: 7), period: :all)
  
  if @start > Date.current + Faker::Number.between(from: 1, to: 7)
    @end = @start 
  else
    @end = Faker::Time.between_dates(from: @start, to: Date.current + Faker::Number.between(from: 2, to: 7), period: :all)
  end

  if Equipment.find(@num2).available == true
    Borrow.create(
      user_id: @num,
      equipment_id: @num2,
      start_time: @start,
      anticipated_end_time: @end
    )
    Equipment.find(@num2).update(available: false)
  end
end

