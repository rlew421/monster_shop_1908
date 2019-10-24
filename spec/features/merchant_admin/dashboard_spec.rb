require 'rails_helper'

describe "When I visit my dashboard as a Merchant" do
  before :each do
    @merchant_user = User.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
  end

  it "Shows me that merchant's name and full address" do
    visit "/merchant/#{@merchant_user.id}"
    expect(page).to have_content('Ross')
    expect(page).to have_content('56 HairGel Ave')
    expect(page).to have_content('Las Vegas')
    expect(page).to have_content('Nevada')
    expect(page).to have_content('65041')
  end

  describe "Shows me a list of pending orders with my items"
    it "Has Order id (links to order show), date of order, quantity of my items, total value of my items" do
      pull_toy = @merchant_user.merchant.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = @merchant_user.merchant.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')


    end
end
