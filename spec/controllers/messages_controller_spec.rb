require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:chat_group) { create(:chat_group, user_ids: user.id) }

    context 'with logged in user' do
      before do
        login_user
        allow(controller).to receive(:current_user).and_return(user)
      end

      context 'when current_user belongs to chat_group' do
        before do
          get :index, params: { chat_group_id: chat_group }
        end

        it 'renders the :index template' do
          expect(response).to render_template :index
        end

        it 'assigns the requested contact to chat_group' do
          expect(assigns(:chat_group)).to eq chat_group
        end

        it 'assigns the requested contact to chat_groups' do
          chat_groups = user.chat_groups.includes(:messages).all
          expect(assigns(:chat_groups)).to eq chat_groups
        end
      end

      context 'when current_user does not belongs_to chat_group' do
        it 'redirects to root_path' do
          chat_group = create(:chat_group)
          get :index, params: { chat_group_id: chat_group }
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'without logged in user' do
      it 'redirects to new_user_session_path' do
        get :index, params: { chat_group_id: chat_group }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:chat_group) { create(:chat_group, user_ids: user.id) }

    before do
      login_user
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'when message.text exists' do
      it 'redirects_to chat_groups_messages_path' do
        post :create, params: { chat_group_id: chat_group, message: attributes_for(:message, chat_group_id: chat_group.id, user_id: user.id) }
        expect(response).to redirect_to chat_group_messages_path(chat_group)
      end

      it 'saves the new contact in the database' do
        expect{
          post :create, params: { chat_group_id: chat_group, message: attributes_for(:message, chat_group_id: chat_group.id, user_id: user.id) }
        }.to change(Message, :count).by(1)
      end
    end

    context 'when message.text empty' do
    end
  end
end
