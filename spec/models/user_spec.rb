require 'rails_helper'
RSpec.describe User, type: :model do
  

  before(:each) do
    @user = FactoryBot.build(:User)
  end
  
  it "name cannot be empty" do
    expect(@user.name).to eq("Michael Example")
  end

  it "should be valid" do
    expect(true).to be(@user.valid?)
  end

  it "name should be present" do
    @user.name = "     "
    expect(false).to be(@user.valid?)
  end

  it "email should be present" do
    @user.email = "     "
    expect(false).to be(@user.valid?)
  end

  it "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
    @user.email = valid_address
    expect(true).to be(@user.valid?), "#{valid_address.inspect} should be valid"
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    expect(false).to be(@user.valid?), "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    @duplicate_user = @user.dup
    @duplicate_user.email = @user.email.downcase
    @user.save
    expect(false).to be(@duplicate_user.valid?)
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(false).to be(@user.valid?)
  end



end
