require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #verify" do
    it "returns http ok" do
      email = "test@tests.com"
      image = "123123"
      User.create(email: email, image: image)

      request.headers["Authorization"] = "aeqGNC313Xqe1P4uI765kAJqRPr13OTY"
      post :verify, params: {email: email, image: image}
      expect(response).to have_http_status(:ok)
    end

    it "returns http unauthorized" do
      email = "test@tests.com"
      image = "123123"
      User.create(email: email, image: "321321")
      
      request.headers["Authorization"] = "aeqGNC313Xqe1P4uI765kAJqRPr13OTY"
      post :verify, params: {email: email, image: image}
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
