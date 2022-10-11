require "rails_helper"

RSpec.describe RetailersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/retailers").to route_to("retailers#index")
    end

    it "routes to #new" do
      expect(get: "/retailers/new").to route_to("retailers#new")
    end

    it "routes to #show" do
      expect(get: "/retailers/1").to route_to("retailers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/retailers/1/edit").to route_to("retailers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/retailers").to route_to("retailers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/retailers/1").to route_to("retailers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/retailers/1").to route_to("retailers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/retailers/1").to route_to("retailers#destroy", id: "1")
    end
  end
end
