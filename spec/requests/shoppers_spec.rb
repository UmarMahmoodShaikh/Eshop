require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/shoppers", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Shopper. As you add validations to Shopper, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Shopper.create! valid_attributes
      get shoppers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      shopper = Shopper.create! valid_attributes
      get shopper_url(shopper)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_shopper_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      shopper = Shopper.create! valid_attributes
      get edit_shopper_url(shopper)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Shopper" do
        expect {
          post shoppers_url, params: { shopper: valid_attributes }
        }.to change(Shopper, :count).by(1)
      end

      it "redirects to the created shopper" do
        post shoppers_url, params: { shopper: valid_attributes }
        expect(response).to redirect_to(shopper_url(Shopper.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Shopper" do
        expect {
          post shoppers_url, params: { shopper: invalid_attributes }
        }.to change(Shopper, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post shoppers_url, params: { shopper: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested shopper" do
        shopper = Shopper.create! valid_attributes
        patch shopper_url(shopper), params: { shopper: new_attributes }
        shopper.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the shopper" do
        shopper = Shopper.create! valid_attributes
        patch shopper_url(shopper), params: { shopper: new_attributes }
        shopper.reload
        expect(response).to redirect_to(shopper_url(shopper))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        shopper = Shopper.create! valid_attributes
        patch shopper_url(shopper), params: { shopper: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested shopper" do
      shopper = Shopper.create! valid_attributes
      expect {
        delete shopper_url(shopper)
      }.to change(Shopper, :count).by(-1)
    end

    it "redirects to the shoppers list" do
      shopper = Shopper.create! valid_attributes
      delete shopper_url(shopper)
      expect(response).to redirect_to(shoppers_url)
    end
  end
end
