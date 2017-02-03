require 'spec_helper'

describe User do
  describe 'from the User model' do
    context 'when a new user signs up' do
      let(:user) { FactoryGirl.build(:user) }

      it 'should create a valid user' do
        expect(user).to be_valid
      end
    end

    context 'when email is not present' do
      let(:user) { FactoryGirl.build(:user, email: ' ') }
      
      it 'should not create a user' do
        expect(user).to_not be_valid
      end
    end
  end
end
