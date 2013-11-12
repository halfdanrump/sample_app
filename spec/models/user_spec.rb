require 'spec_helper'

describe User do
  before { @user = User.new name: 'Halfdan', email:'dalekk@gmail.com', password: 'foobar', password_confirmation: 'foobar'}
  subject {@user}
  it {should respond_to :name}
  it {should respond_to :email}
  it {should respond_to :password_digest}
  it {should respond_to :password}
  it {should respond_to :password_confirmation}
  it {should respond_to :authenticate}

  it {should be_valid}

  describe 'user has invalid name' do
  	before{ @user.name = '' }
  	it {should_not be_valid}

  	before{ @user.name = 'a' * 51 }
  	it {should_not be_valid}
  end

  describe 'user has valid email' do
  	it 'should be valid' do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each { |address|
  			@user.email = address
  			expect(@user).to be_valid
  		}
  	end
  end

  describe 'user has invalid email' do
  	it 'should be valid' do
  		addresses = %w[userfoo.COM A_US-ER@f,b.org frst lst@foojp a+b@baz.+cn]
  		addresses.each { |address|
  			@user.email = address
  			expect(@user).not_to be_valid
  		}
  	end
  end

  describe 'when user tries to sign up with an already registered email' do
  	before{ 
  		user2 = @user.dup
  		user2.save
  		@user.email = 'Dalekk@gmail.com'
  	}

  	it {should_not be_valid}
  end

  describe 'when user enters blank password' do
  	before {
  		@user.password = ''
  		@user.password_confirmation = ''
  	}
  	it {should_not be_valid}
  end

  describe 'passwords do not match' do
  	before {
  		@user.password = 'foobar'
  		@user.password_confirmation = 'barfoo'
  	}
  	it {should_not be_valid}
  end

  describe 'requirements of the authenticate method' do
  	before { @user.save }
  	let(:found_user){User.find_by email: @user.email}
  	describe 'user has valid password' do
  		it {should eq found_user.authenticate(@user.password)}
  	end

  	describe 'user has invalid password' do
  		it {should_not eq found_user.authenticate("asdasd")}
  	end

  end

  describe 'user enters a password that is too short' do
  	before {@user.password = @user.password_confirmation = 'aaaaa'}
  	it {should_not be_valid}
  end


end



