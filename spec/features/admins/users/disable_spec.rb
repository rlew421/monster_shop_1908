require 'rails_helper'

describe 'admin can disable a user account' do
  before(:each) do
    @admin = User.create!(name: 'Monica', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'cleaner@gmail.com', password: 'monmon', role: 3)
    @user_1 = User.create!(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', email: "young_money99@gmail.com", password: "momoneymoprobz", is_active: false)
    @user_2 = User.create!(name: 'Alice Wonder', address: '346 Underground Blvd', city: 'NY', state: 'New York', zip: '10221', email: "alice_in_the_sky@gmail.com", password: "cheshirecheezin")
    @user_3 = User.create!(name: 'Sonny Moore', address: '87 Electric Ave', city: 'NY', state: 'New York', zip: '10221', email: "its_always_sonny@gmail.com", password: "beatz")

    suite_deal= Merchant.create(name: "Suite Deal Home Goods", address: '1280 Park Ave', city: 'Denver', state: 'CO', zip: "80202")
    knit_wit = Merchant.create(name: "Knit Wit", address: '123 Main St.', city: 'Denver', state: 'CO', zip: "80218")
    a_latte_fun = Merchant.create(name: "A Latte Fun", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: "80210")

    dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    @merchant_employee = dog_shop.users.create!(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 1)


    pawty_city = Merchant.create(name: "Paw-ty City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @merchant_admin = pawty_city.users.create!(name: 'Monicahh', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'anothercleaner@gmail.com', password: 'monmon', role: 2)

  end
  it 'enabled user can login' do
    visit '/'
    click_link 'Login'
    fill_in :email, with: @user_2.email
    fill_in :password, with: @user_2.password
    click_button 'Log In'

    expect(current_path).to eq("/profile/#{@user_2.id}")
    expect(page).to have_content('Welcome, Alice Wonder! You are logged in.')
  end
  it 'from user index page admin can click to disable users not disabled' do
    visit '/'
    click_link 'Login'
    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button 'Log In'

    visit '/admin/users'

    within "#users-#{@user_1.id}" do
      expect(page).to have_link('Enable')
    end

    within "#users-#{@user_3.id}" do
      expect(page).to have_link('Disable')
    end

    within "#users-#{@user_2.id}" do
      click_link 'Disable'
    end

    @user_2.reload
    expect(current_path).to eq('/admin/users')
    expect(page).to have_content("#{@user_2.name}'s account has been disabled.")

    expect(@user_2.is_active).to eq(false)

    click_link 'Log Out'

    click_link 'Login'

    fill_in :email, with: @user_2.email
    fill_in :password, with: @user_2.password
    click_button 'Log In'


    expect(current_path).to eq('/login')
    expect(page).to have_content('Unable to login. Your account has been deactivated')
  end
end
