require 'rails_helper'

describe 'User visits homepage' do
  describe "User is not logged in" do
    it "should show a login form" do
      visit root_path

      expect(page).to have_content("Log In")
      expect(page).to have_field("Username")
      expect(page).to have_field("Password")
    end
  end
  describe "User is logged in" do
    it "should redirect to users show page" do
      # user = User.create(name: "Ben", username: "bman3000")
    end
  end
end
