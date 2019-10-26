require 'rails_helper'


describe 'when I visit merchant dashboard' do
  it 'displays name and address of the merchant I work fo as an employee' do
    pawty_city = Merchant.create(name: "Paw-ty City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    pull_toy = pawty_city.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    merchant_employee = dog_shop.users.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 1)

    user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')


    order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    order_2 = user.orders.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204)
    order_3 = user.orders.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210)

    order_1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 3)
    order_2.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 2)
    order_2.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    order_3.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5)
    visit '/'
    click_link 'Login'

    fill_in :email, with: merchant_employee.email
    fill_in :password, with: merchant_employee.password
    click_button 'Log In'
    visit '/merchant'

    expect(page).to have_content("Employer: Meg's Dog Shop")
    expect(page).to have_content('Address: 123 Dog Rd.')
    expect(page).to have_content('City: Hershey')
    expect(page).to have_content('State: PA')
    expect(page).to have_content('Zip Code: 80203')
  end
  it 'displays name and address of the merchant I work for as an admin' do
    user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')
    dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    pawty_city = Merchant.create(name: "Paw-ty City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    pull_toy = pawty_city.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)


    order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    order_2 = user.orders.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204)
    order_3 = user.orders.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210)

    order_1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 3)
    order_2.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 2)
    order_2.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
    order_3.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5)
    merchant_admin = pawty_city.users.create(name: 'Monica', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'cleaner@gmail.com', password: 'monmon', role: 2)
    visit '/'
    click_link 'Login'

    fill_in :email, with: merchant_admin.email
    fill_in :password, with: merchant_admin.password
    click_button 'Log In'

    visit '/merchant'

    expect(page).to have_content("Employer: Paw-ty City")
    expect(page).to have_content('Address: 123 Bike Rd.')
    expect(page).to have_content('City: Denver')
    expect(page).to have_content('State: CO')
    expect(page).to have_content('Zip Code: 80203')
  end
  it 'as a merchant I see pending orders with my items' do


  end


end
