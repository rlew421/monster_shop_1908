require 'rails_helper'

describe 'upgrade user to merchant' do
  before(:each) do
    @admin = User.create(name: 'Monica', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'cleaner@gmail.com', password: 'monmon', role: 3)
    @user_1 = User.create(name: 'Richy Rich', address: '102 Main St', city: 'NY', state: 'New York', zip: '10221', email: "young_money99@gmail.com", password: "momoneymoprobz")
    @user_2 = User.create(name: 'Alice Wonder', address: '346 Underground Blvd', city: 'NY', state: 'New York', zip: '10221', email: "alice_in_the_sky@gmail.com", password: "cheshirecheezin")
    @user_3 = User.create(name: 'Sonny Moore', address: '87 Electric Ave', city: 'NY', state: 'New York', zip: '10221', email: "its_always_sonny@gmail.com", password: "beatz")

    @suite_deal= Merchant.create(name: "Suite Deal Home Goods", address: '1280 Park Ave', city: 'Denver', state: 'CO', zip: "80202")
    @knit_wit = Merchant.create(name: "Knit Wit", address: '123 Main St.', city: 'Denver', state: 'CO', zip: "80218")
    @a_latte_fun = Merchant.create(name: "A Latte Fun", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: "80210")

    dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    @merchant_employee = dog_shop.users.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 1)
    dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    pawty_city = Merchant.create(name: "Paw-ty City", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: "80203")
    @merchant_admin = pawty_city.users.create(name: 'Monica', address: '75 Chef Ave', city: 'Utica', state: 'New York', zip: '45827', email: 'cleaner@gmail.com', password: 'monmon', role: 2)
    pull_toy = pawty_city.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    banana = pawty_city.items.create(name: "Banana Costume", description: "Don't let this costume slip by you!", price: 13.50, image: "https://i.imgur.com/Eg0lBXd.jpg", inventory: 7)
    shark = pawty_city.items.create(name: "Baby Shark Costume", description: "Baby shark, doo doo doo doo doo doo doo... ", price: 23.75, image: "https://i.imgur.com/gzRbKT2.jpg", inventory: 2)
    harry_potter = pawty_city.items.create(name: "Harry Potter Costume", description: "Look who got into Hogwarts.", price: 16.00, image: "https://i.imgur.com/GC4ppbA.jpg", inventory: 13)



    @order_1 = @user_1.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 'packaged')
    @order_2 = @user_2.orders.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204)
    @order_3 = @user_3.orders.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210, status: 'shipped')
    @order_4 = @user_3.orders.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210, status: 'cancelled')

    @order_1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 3, merchant: pawty_city)
    @order_2.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 2, merchant: dog_shop)
    @order_2.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2, merchant: pawty_city)
    @order_3.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5, merchant: dog_shop)
    @order_4.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 5, merchant: dog_shop)
    @order_4.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 5, merchant: pawty_city)
    @order_4.item_orders.create!(item: harry_potter, price: harry_potter.price, quantity: 5, merchant: pawty_city)

    visit '/'
    click_link 'Login'
    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button 'Log In'
  end

  it "can upgrade default user to merchant user" do
    visit '/admin/users'

    within "#users-#{@user_1.id}" do
      click_link "Upgrade to Merchant User"
    end

    select("#{@suite_deal.name}", from: 'merchant')
    select("Employee", from: 'role')
    click_button 'Submit Change'

    @user_1.reload
    expect(current_path).to eq('/admin/users')
    expect(@user_1.role).to eq('merchant_employee')
    expect(@user_1.merchant.name).to eq('Suite Deal Home Goods')

    visit '/admin/users'

    within "#users-#{@user_2.id}" do
      click_link "Upgrade to Merchant User"
    end

    select("#{@knit_wit.name}", from: 'merchant')
    select("Admin", from: 'role')
    click_button 'Submit Change'

    @user_2.reload
    expect(current_path).to eq('/admin/users')
    expect(@user_2.role).to eq('merchant_admin')
    expect(@user_2.merchant.name).to eq('Knit Wit')

    visit '/admin/users'

    within "#users-#{@user_3.id}" do
     click_link "Upgrade to Merchant User"
    end

    select("#{@a_latte_fun.name}", from: 'merchant')
    select("Employee", from: 'role')
    click_button 'Submit Change'

    @user_3.reload
    expect(current_path).to eq('/admin/users')
    expect(@user_3.role).to eq('merchant_employee')
    expect(@user_3.merchant.name).to eq('A Latte Fun')


  end
end
