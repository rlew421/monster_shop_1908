require 'rails_helper'

RSpec.describe "admin dashboard" do
  before(:each) do
    @admin = User.create(name: 'Monica', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'cleaner@gmail.com', password: 'monmon', role: 3)

    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    @user_1 = User.create(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', email: "young_money99@gmail.com", password: "momoneymoprobz")
    @user_2 = User.create(name: 'Alice Wonder', address: '346 Underground Blvd', city: 'NY', state: 'New York', zip: '10221', email: "alice_in_the_sky@gmail.com", password: "cheshirecheezin")
    @user_3 = User.create(name: 'Sonny Moore', address: '87 Electric Ave', city: 'NY', state: 'New York', zip: '10221', email: "its_always_sonny@gmail.com", password: "beatz")
  end

  it "I can see all default users with their info and perform the following actions:
   - edit user profile
   - edit user password
   - upgrade a user to a merchant account" do

   visit '/admin/users'

   within "#users-#{@user_1.id}" do
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(@user_1.address)
    expect(page).to have_content(@user_1.city)
    expect(page).to have_content(@user_1.state)
    expect(page).to have_content(@user_1.zip)
    expect(page).to have_content(@user_1.email)
    expect(page).to have_link("Edit Profile")
    expect(page).to have_link("Edit Password")
    expect(page).to have_link("Upgrade to Merchant Employee")
    expect(page).to have_link("Upgrade to Merchant Admin")

    click_link "Edit Profile"
    expect(current_path).to eq("/admin/users/#{@user_1.id}/edit")
   end

   visit '/admin/users'

   within "#users-#{@user_1.id}" do
    click_link "Edit Password"
    expect(current_path).to eq("/admin/users/#{@user_1.id}/edit/password")
   end

   visit '/admin/users'

   within "#users-#{@user_2.id}" do
    expect(page).to have_content(@user_2.name)
    expect(page).to have_content(@user_2.address)
    expect(page).to have_content(@user_2.city)
    expect(page).to have_content(@user_2.state)
    expect(page).to have_content(@user_2.zip)
    expect(page).to have_content(@user_2.email)
    expect(page).to have_link("Edit Profile")
    expect(page).to have_link("Edit Password")
    expect(page).to have_link("Upgrade to Merchant Employee")
    expect(page).to have_link("Upgrade to Merchant Admin")

    click_link "Edit Profile"
    expect(current_path).to eq("/admin/users/#{@user_2.id}/edit")
   end

   visit '/admin/users'

   within "#users-#{@user_2.id}" do
    click_link "Edit Password"
    expect(current_path).to eq("/admin/users/#{@user_2.id}/edit/password")
   end

   visit '/admin/users'

   within "#users-#{@user_3.id}" do
    expect(page).to have_content(@user_3.name)
    expect(page).to have_content(@user_3.address)
    expect(page).to have_content(@user_3.city)
    expect(page).to have_content(@user_3.state)
    expect(page).to have_content(@user_3.zip)
    expect(page).to have_content(@user_3.email)
    expect(page).to have_link("Edit Profile")
    expect(page).to have_link("Edit Password")
    expect(page).to have_link("Upgrade to Merchant Employee")
    expect(page).to have_link("Upgrade to Merchant Admin")

    click_link "Edit Profile"
    expect(current_path).to eq("/admin/users/#{@user_3.id}/edit")
   end

   visit '/admin/users'

   within "#users-#{@user_3.id}" do
    click_link "Edit Password"
    expect(current_path).to eq("/admin/users/#{@user_3.id}/edit/password")
   end
 end

  it "can upgrade default user to merchant employee" do
    visit '/admin/users'

    within "#users-#{@user_1.id}" do
      click_link "Upgrade to Merchant Employee"
     end
     @user_1.reload
     expect(current_path).to eq('/admin/users')
     expect(@user_1.role).to eq("merchant_employee")

    visit '/admin/users'

    within "#users-#{@user_2.id}" do
      click_link "Upgrade to Merchant Employee"
      @user_2.reload
     end
     expect(current_path).to eq('/admin/users')
     expect(@user_2.role).to eq("merchant_employee")

    visit '/admin/users'

    within "#users-#{@user_3.id}" do
     click_link "Upgrade to Merchant Employee"
     @user_3.reload
    end
    expect(current_path).to eq('/admin/users')
    expect(@user_3.role).to eq("merchant_employee")
  end

  it "can upgrade default user to merchant admin" do
    visit '/admin/users'

    within "#users-#{@user_1.id}" do
    click_link "Upgrade to Merchant Admin"
    end
    @user_1.reload
    expect(current_path).to eq('/admin/users')
    expect(@user_1.role).to eq("merchant_admin")

    visit '/admin/users'

    within "#users-#{@user_2.id}" do
    click_link "Upgrade to Merchant Admin"
    @user_2.reload
    end
    expect(current_path).to eq('/admin/users')
    expect(@user_2.role).to eq("merchant_admin")

    visit '/admin/users'

    within "#users-#{@user_3.id}" do
    click_link "Upgrade to Merchant Admin"
    @user_3.reload
    end
    expect(current_path).to eq('/admin/users')
    expect(@user_3.role).to eq("merchant_admin")
  end

  it "can edit default user profile" do
    visit '/admin/users'

    within "#users-#{@user_1.id}" do
      click_link "Edit Profile"
    end
    expect(current_path).to eq("/admin/users/#{@user_1.id}/edit")

    expect(find_field('Name').value).to eq "Richy Rich"
    expect(find_field('Address').value).to eq "102 Main St"
    expect(find_field('City').value).to eq "NY"
    expect(find_field('State').value).to eq "New York"
    expect(find_field('Zip').value).to eq "10221"
    expect(find_field('Email').value).to eq "young_money99@gmail.com"

    fill_in 'Name', with: "Poory Poor"
    fill_in 'Address', with: "104 Not Main St"
    fill_in 'Zip', with: "10221"
    fill_in 'Email', with: "old_money99@gmail.com"

    click_button 'Submit Changes'

    expect(current_path).to eq('/admin/users')

    within "#users-#{@user_1.id}" do
      expect(current_path).to eq('/admin/users')
      expect(page).to have_content("Poory Poor")
      expect(page).to have_content("104 Not Main St")
      expect(page).to have_content("NY")
      expect(page).to have_content("New York")
      expect(page).to have_content("10221")
      expect(page).to have_content("old_money99@gmail.com")
    end
  end

  it "can edit default user password" do
    visit '/merchants'
    click_link 'Login'

    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button 'Log In'

    visit '/admin/users'

    within "#users-#{@user_1.id}" do
      click_link "Edit Password"
    end

    expect(current_path).to eq("/admin/users/#{@user_1.id}/edit/password")

    expect(page).to have_field('Password')
    expect(page).to have_field('Password confirmation')

    fill_in 'Password', with: "newpasswordwhodis"
    fill_in 'Password confirmation', with: "newpasswordwhodis"
    click_button 'Submit Changes'
    
    @user_1.reload

    expect(current_path).to eq('/admin/users')
    expect(page).to have_content("You have successfully updated #{@user_1.name}'s password!")
    expect(@user_1.password).to eq("newpasswordwhodis")
  end
end
