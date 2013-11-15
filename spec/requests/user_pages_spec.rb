require 'spec_helper'

describe "User pages" do
	subject { page }

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
	end

	describe 'signup', focus:true do
		before {visit signup_path} 
		
		describe "signup page" do
			before { visit signup_path}

			it {should have_content 'Sign up'}
			it {should have_title full_title('Sign up')}
		end

		describe 'user tries to sign up with valid data' do
			before{
				fill_in "Name", with: "Halfdan"
				fill_in "Email", with: "dalekk@gmail.com"
				fill_in "Password", with: "foorbar"
				fill_in "Confirmation", with: "foorbar"	
			}
			it 'should create one user' do
				expect { click_button "Create my account!"}.to change(User, :count).by(1)
			end
		end

		describe 'user tries to sign up with invalid data' do
			it 'should not create a user' do
				expect { click_button "Create my account!"}.not_to change(User, :count)
			end
		end
	end	
end