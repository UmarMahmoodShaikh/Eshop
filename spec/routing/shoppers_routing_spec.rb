require "rails_helper"

RSpec.describe ShoppersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/shoppers").to route_to("shoppers#index")
    end

    it "routes to #new" do
      expect(get: "/shoppers/new").to route_to("shoppers#new")
    end

    it "routes to #show" do
      expect(get: "/shoppers/1").to route_to("shoppers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/shoppers/1/edit").to route_to("shoppers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/shoppers").to route_to("shoppers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/shoppers/1").to route_to("shoppers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/shoppers/1").to route_to("shoppers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/shoppers/1").to route_to("shoppers#destroy", id: "1")
    end
  end
end
