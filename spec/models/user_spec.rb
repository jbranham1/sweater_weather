require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'isntance methods' do
    describe 'create_api_key' do
      it 'it creates a random uuid for the user' do
        user = User.create(email: "email@email.com", password: 'password')
        expect(user.create_api_key).to be_a String
      end
    end
  end
end
