require 'rails_helper'

RSpec.describe User, type: :model do
  it "create user" do
    email = "test@tests.com"
    image = "123123"
    User.create(email: email, image:image)

    expect(User.count).to eq(1)
  end
end
