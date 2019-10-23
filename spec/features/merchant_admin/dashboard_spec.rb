require 'rails_helper'

describe "When I visit my dashboard as a Merchant" do
  before :each do
    @merchant = User.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
  end

  it "Shows me that merchant's name and full address" do
    visit "/merchant/#{@merchant.id}"
    expect(page).to have_content('Ross')
    expect(page).to have_content('56 HairGel Ave')
    expect(page).to have_content('Las Vegas')
    expect(page).to have_content('Nevada')
    expect(page).to have_content('65041')
  end
end
