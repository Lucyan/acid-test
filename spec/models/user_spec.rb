require 'rails_helper'

RSpec.describe User, type: :model do
  it "crear usuario" do
    email = "test@tests.com"
    image = "123123"
    User.create(email: email, image:image)

    expect(User.where(email: email).count).to eq(1)
  end

  it "usuario con email valido" do
    email = "email"
    image = "123123"
    begin
        user = User.create!(email: email, image: image)
    rescue
        user = nil
    end
    expect(user).to eq(nil)
  end
end
