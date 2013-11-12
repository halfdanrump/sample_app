require 'spec_helper'

describe User do
  before { @user = User.new name: 'Halfdan', email:'dalekk@gmail.com'}
  subject {@user}
  it {should respond_to :name}
  it {should respond_to :email}
  it {should respond_to :password_digest}

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
  		user2 = User.new name:'Halfdan', email:'dalekk@gmail.com'
  		user2.save
  		@user.email = 'Dalekk@gmail.com'
  	}

  	it {should_not be_valid}
  end

end

