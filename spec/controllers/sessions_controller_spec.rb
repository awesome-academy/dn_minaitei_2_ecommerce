require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { session: { email: 'test@example.com', password: 'password' } } }
    let(:invalid_attributes) { { session: { email: '', password: '' } } }

    context 'with valid attributes' do
      it 'logs in the user' do
        account = create(:account)
        post :create, params: valid_attributes
        expect(session[:account_id]).to eq(account.id)
      end

      it 'redirects to root path' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(root_path)
      end

      it 'shows flash success message' do
        post :create, params: valid_attributes
        expect(flash[:success]).to eq(I18n.t("sessions.login_success"))
      end
    end

    context 'with invalid attributes' do
      it 'renders the new template' do
        post :create, params: invalid_attributes
        expect(response).to render_template(:new)
      end

      it 'shows flash error message for invalid email' do
        post :create, params: invalid_attributes
        expect(flash[:error]).to eq(I18n.t("sessions.login_email_err"))
      end

      it 'shows flash error message for invalid password' do
        account = create(:account)
        post :create, params: { session: { email: account.email, password: 'wrong_password' } }
        expect(flash[:error]).to eq(I18n.t("sessions.login_password_err"))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user' do
      delete :destroy
      expect(session[:account_id]).to be_nil
    end

    it 'redirects to root path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
