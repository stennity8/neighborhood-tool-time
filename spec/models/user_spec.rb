require 'rails_helper'
require 'pry'

RSpec.describe User, type: :model do
    let(:user) {
      User.create(
        :name => "Ron Burgundy",
        :email => "ron@ron.com",
        :password => "password",
      )
    }

    let(:first_category) {
      Category.create(
        title: "Hand Tools"
      )
    }

    it "is valid with a name, email, and password" do
      expect(user).to be_valid
    end
    
    it "is not valid without a password" do
      expect(User.new(name: "Name")).not_to be_valid
    end
    
    it "has many owned equipments" do
      first_equipment = Equipment.new(name: "Hammer",description: "It is a standard hammer.", user_id: user.id, brand: "Dewault")
      first_equipment.categories << first_category
      first_equipment.save
      expect(user.owned_equipments.first.categories).to eq([first_category])
    end
  
end
