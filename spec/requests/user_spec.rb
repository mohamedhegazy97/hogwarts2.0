=begin
require 'rails_helper'
RSpec.describe User, type: :request do
  user = FactoryBot.build(:User)
  describe "POST create" do
    context "with invalid attributes" do
        it "re-renders the new method" do
          get user_path
          post signup_path , @user
          expect( response ).to render_template @user
        end 
    end
end
end
=end