require_relative "../rails_helper.rb"

def user_signup
  fill_in("user_name", :with => "Amy Poehler")
  fill_in("user_email", :with => "amy@amy.com")
  fill_in("user_password", :with => "password")
  fill_in("user_password_confirmation", :with => "password")
  click_button('Sign up')
end

def user_login
  fill_in("user_email", :with => "mindy@mindy.com")
  fill_in("user_password", :with => "password")
  click_button('Log in')
end

def create_standard_user 
  @mindy = User.create(
    name: "Mindy",
    email: "mindy@mindy.com",
    password: "password",
    )
end

describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully signs up' do
    visit '/users/sign_up'
    expect(current_path).to eq('/users/sign_up')
    user_signup
    expect(current_path).to eq('/')

  end
  
  it 'successfully logs in' do
    create_standard_user
    visit '/users/sign_in'
    expect(current_path).to eq('/users/sign_in')
    user_login
    expect(current_path).to eq('/')
  end
end