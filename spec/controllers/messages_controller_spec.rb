require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    let(:user) { create(:user) }

    context 'with logged in user' do
      before do
        login_user
        allow(controller).to receive(:current_user).and_return(user)
      end

      context 'when current_user belongs to @chat_group' do
        let(:chat_group) { create(:chat_group, user_ids: user.id) }
        before do
          get :index, chat_group_id: chat_group
        end

        it "renders the :index template" do
          expect(response).to render_template :index
        end

        it "assigns the requested contact to @chat_group" do
          expect(assigns(:chat_group)).to eq chat_group
        end

        it "assigns the requested contact to @chat_groups" do
          chat_groups = user.chat_groups.includes(:messages).all
          expect(assigns(:chat_groups)).to eq chat_groups
        end
      end

      context 'when current_user does not belongs_to @chat_group' do
        let(:chat_group) { create(:chat_group) }
        before do
          get :index, chat_group_id: chat_group
        end

        it 'redirects and havs 302 status' do
          expect(response).to have_http_status(302)
        end
      end
    end

    context 'without logged in user' do
      let(:chat_group) { create(:chat_group, user_ids: user.id) }
      before do
        get :index, chat_group_id: chat_group
      end

      it 'redirects and has 302 status' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST #create' do
  end
end
