require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

  describe "#new" do
    it "returns http success" do
      get :create
      expect(response.status).to eq 200
    end
  end

  describe "#create" do
    it "returns http success" do
      post :create
      expect(response.status).to eq 200
    end
  end

  describe "#edit" do
    it "returns http success" do
      get :edit
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    it "returns http success" do
      get :update
      expect(response.status).to eq 200
    end
  end

end
