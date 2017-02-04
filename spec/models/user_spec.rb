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
      let(:user) { FactoryGirl.build(:user, email: '  ') }
      
      it 'should not create a user' do
        expect(user).to_not be_valid
      end
    end

    context 'when requests come in for the user' do

      it 'should respond to the auth_token' do 
        expect(User.new).to respond_to(:auth_token)
      end
    end
    
    context 'when #generate_authentication_token!' do 
      let(:user) { FactoryGirl.build(:user) }

      it 'should generate a valid authentication token' do
        Devise.stub(:friendly_token).and_return("uniquetoken123")
        user.generate_authentication_token!
        expect(user.auth_token).to eql 'uniquetoken123'
      end
    end

    context 'when the token is already taken from #generate_authentication_token! ' do 
      let(:existing_user) { FactoryGirl.build(:user, auth_token: 'uniquetoken123') }
      let(:user) { FactoryGirl.build(:user) }

      it 'should generate another token' do
        user.generate_authentication_token!
        expect(user.auth_token).not_to eql existing_user.auth_token
      end
    end
  end
end
