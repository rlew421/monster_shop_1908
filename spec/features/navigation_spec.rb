
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor.' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
        expect(current_path).to eq('/items')
        click_link 'All Merchants'
        expect(current_path).to eq('/merchants')
        click_link 'Home'
        expect(current_path).to eq('/')
      end
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
        click_link 'Cart: 0'
        expect(current_path).to eq('/cart')
        visit '/items'
        expect(page).to have_content("Cart: 0")
        click_link 'Cart: 0'
        expect(current_path).to eq('/cart')
      end
    end

    it 'I can see a link to log in on all pages' do
      visit '/merchants'

      within 'nav' do
        click_link "Login"
        expect(current_path).to eq('/login')
        visit '/items'
        click_link "Login"
        expect(current_path).to eq('/login')
      end
    end

    it 'I can see a link to register on all pages' do
      visit '/merchants'

      within 'nav' do
        click_link 'Register'
        expect(current_path).to eq('/register')
        visit '/items'
        click_link 'Register'
        expect(current_path).to eq('/register')
      end
    end

    it "I can't visit pages I'm not authorized for" do
      visit '/merchant/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin/users'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'As a User.' do
    before :each do
      user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'I see the navbar with links with profile and log out, not login or register' do

      visit '/'

      within 'nav' do
        expect(page).to have_link('All Merchants')
        expect(page).to have_link('All Items')
        expect(page).to have_link('Cart: 0')
        expect(page).to have_content('Logged in as Patti')
        expect(page).to have_link('Log out')
        expect(page).to have_link('Profile')
        expect(page).to_not have_content('Login')
        expect(page).to_not have_content('Register')

        click_link 'Profile'
        expect(current_path).to eq('/profile')
        click_link 'Log out'
        expect(current_path).to eq('/logout')
      end
    end

    it "I can't visit pages I'm not authorized for" do
      visit '/merchant/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin/users'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'As a merchant' do
    before :each do
      merchant = User.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
    end

    it 'I see navbar with links to all pages, profile, logout, dashboard, not login or register' do


      visit '/'

      within 'nav' do
        expect(page).to have_link('All Merchants')
        expect(page).to have_link('All Items')
        expect(page).to have_link('Cart: 0')
        expect(page).to have_content('Logged in as Ross')
        expect(page).to have_link('Log out')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Dashboard')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')

        click_link 'Dashboard'
        expect(current_path).to eq('/merchant/dashboard')
      end
    end

    it "I can't visit pages I'm not authorized for" do
      visit '/admin/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin/users'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'As an Admin' do
    before :each do
      admin = User.create(name: 'Monica', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'cleaner@gmail.com', password: 'monmon', role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    end

    it "I see the regular navbar with addition of the 'Admin Dashboard' and 'All Users' links" do

      visit '/'

      within 'nav' do
        expect(page).to have_link('All Merchants')
        expect(page).to have_link('All Items')
        expect(page).to have_content('Logged in as Monica')
        expect(page).to have_link('Log out')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('All Users')
        expect(page).to_not have_link('Cart: 0')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')

        click_link 'Dashboard'
        expect(current_path).to eq('/admin/dashboard')

        click_link 'All Users'
        expect(current_path).to eq('/admin/users')
      end
    end

    it "I can't visit pages I'm not authorized for" do
      visit '/merchant/dashboard'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/cart'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
