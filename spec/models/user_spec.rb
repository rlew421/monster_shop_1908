require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'roles' do
    it 'can be created as a regular user' do
      user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as a merchant employee' do
      user = User.create(name: 'Joey', address: '76 Pizza Place', city: 'Brooklyn', state: 'New York', zip: '10231', email: 'estelles_best_actor@gmail.com', password: 'letseat', role: 1)

      expect(user.role).to eq('merchant_employee')
      expect(user.merchant_employee?).to be_truthy
    end

    it 'can be created as a merchant admin' do
      user = User.create(name: 'Monica', address: '45 Squeaky Clean St', city: 'Portland', state: 'Maine', zip: '12341', email: 'number_one_chef@gmail.com', password: 'chandlerbing', role: 2)

      expect(user.role).to eq('merchant_admin')
      expect(user.merchant_admin?).to be_truthy
    end

    it 'can be created as an admin' do
      user = User.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 3)

      expect(user.role).to eq('admin')
      expect(user.admin?).to be_truthy
    end
  end
end
