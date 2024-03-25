# frozen_string_literal: true

require "rails_helper"
require "support/shared_examples/login_examples"

RSpec.describe(Accounts::SessionsController, type: :controller) do
  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to(render_template(:new))
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { email: account.email, password: account.password } }

      include_examples "login examples"

      it "redirects to the root path" do
        post :create, params: { account: valid_params }
        expect(response).to(redirect_to(root_path))
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { email: "", password: "" } }

      it "renders the new template" do
        post :create, params: { account: invalid_params }
        expect(response).to(render_template(:new))
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to the root path" do
      delete :destroy
      expect(response).to(redirect_to(root_path))
    end
  end
end
