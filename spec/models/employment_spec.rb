require 'rails_helper'

describe Employment do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should belong_to :user }

  end

  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :merchant_id }
  end

  describe "instance methods" do
    it 'creation' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      user = User.create(name: 'Joey', address: '76 Pizza Place', city: 'Brooklyn', state: 'New York', zip: '10231', email: 'estelles_best_actor@gmail.com', password: 'letseat')

      Employment.creation(user, meg.id)

      expect(Employment.first.merchant_id).to eq(meg.id)
      expect(Employment.first.user_id).to eq(user.id)
      
    end
  end
end
