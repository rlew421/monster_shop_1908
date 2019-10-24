require 'rails_helper'

describe 'As a registered user I am sent to my orders page after creating an order ' do
  it 'displays all of my orders' do
    visit '/'
    @user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')
    click_link 'Login'

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button 'Log In'

    order_1 = @user.orders.create!(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221' )
    order_2 = @user.orders.create!(name: 'Alice Wonder', address: '346 Underground Blvd', city: 'NY', state: 'New York', zip: '10221' )
    order_3 = @user.orders.create!(name: 'Sonny Moore', address: '87 Electric Ave', city: 'NY', state: 'New York', zip: '10221' )

    visit "/profile/orders"

    within "#orders-#{order_1.id}" do
      expect(page).to have_content('Ship to:')
      expect(page).to have_content('Name: Richy Rich')
      expect(page).to have_content('Address: 102 Main St')
      expect(page).to have_content('City: NY')
      expect(page).to have_content('State: New York')
      expect(page).to have_content('Zip: 10221')
   end

    within "#orders-#{order_2.id}" do
      expect(page).to have_content('Ship to:')
      expect(page).to have_content('Name: Alice Wonder')
      expect(page).to have_content('Address: 346 Underground Blvd')
      expect(page).to have_content('City: NY')
      expect(page).to have_content('State: New York')
      expect(page).to have_content('Zip: 10221')
   end

    within "#orders-#{order_3.id}" do
      expect(page).to have_content('Ship to:')
      expect(page).to have_content('Name: Sonny Moore')
      expect(page).to have_content('Address: 87 Electric Ave')
      expect(page).to have_content('City: NY')
      expect(page).to have_content('State: New York')
      expect(page).to have_content('Zip: 10221')
   end
 end
end
