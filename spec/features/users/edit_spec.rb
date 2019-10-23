require 'rails_helper'

describe "As a regular User" do
  describe "When I visit my profile page and click link to edit profile" do
    before :each do
      @user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it "Prompts me to edit my profile with a form" do

      visit "/profile/#{@user.id}"
      click_link 'Edit Profile'

      expect(current_path).to eq("/profile/#{@user.id}/edit")
      expect(find_field('Name').value).to eq "Patti"
      expect(find_field('Address').value).to eq "953 Sunshine Ave"
      expect(find_field('City').value).to eq "Honolulu"
      expect(find_field('State').value).to eq "Hawaii"
      expect(find_field('Zip').value).to eq "96701"
      expect(find_field('Email').value).to eq "pattimonkey34@gmail.com"

      fill_in 'Name', with: "Pat"
      fill_in 'Address', with: "333 Round dr"
      fill_in 'City', with: "Cleveland"
      fill_in 'State', with: "Ohio"
      fill_in 'Zip', with: "74423"
      fill_in 'Email', with: "patmonkey@gmail.com"

      click_button 'Complete Changes'

      expect(current_path).to eq("/profile/#{@user.id}")
      expect(page).to have_content('Hello, Pat! You have successfully updated your profile.')
      expect(page).to have_content('Address: 333 Round dr')
      expect(page).to have_content('City: Cleveland')
      expect(page).to have_content('State: Ohio')
      expect(page).to have_content('Zip Code: 74423')
      expect(page).to have_content('E-mail: patmonkey@gmail.com')

      visit "/profile/#{@user.id}"
      click_link 'Edit Profile'

      fill_in 'Name', with: "Patty"
      fill_in 'Address', with: "homeless"
      click_button 'Complete Changes'
      
      expect(page).to have_content('Hello, Patty! You have successfully updated your profile.')
      expect(page).to have_content('Address: homeless')

    end
  end
end
