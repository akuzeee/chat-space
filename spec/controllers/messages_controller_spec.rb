require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:chat_group) { create(:chat_group, users: [user]) }

    context 'with logged in user' do
      before do
        login_user user
      end

      context 'when current_user belongs to chat_group' do
        let(:request) { get :index, params: { chat_group_id: chat_group } }

        it 'renders the :index template' do
          request
          expect(response).to render_template :index
        end

        it 'assigns the requested contact to chat_group' do
          request
          expect(assigns(:chat_group)).to eq chat_group
        end

        it 'assigns the requested contact to chat_groups' do
          chat_groups = user.chat_groups
          request
          expect(assigns(:chat_groups)).to eq chat_groups
        end

        it 'assigns the requested contact to message' do
          request
          expect(assigns(:message)).to be_a_new(Message)
        end
      end

      context 'when current_user does not belong_to chat_group' do
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
    let(:chat_group) { create(:chat_group, users: [user]) }
    before do
      login_user user
    end

    context 'with valid attributes' do
      let(:request) { post :create, params: { chat_group_id: chat_group, message: attributes_for(:message, chat_group_id: chat_group.id, user_id: user.id) } }

      it 'redirects_to chat_groups_messages_path' do
        request
        expect(response).to redirect_to chat_group_messages_path(chat_group)
      end

      it 'saves the new contact in the database' do
        expect{ request }.to change(Message, :count).by(1)
      end

      it 'contains notice flash message' do
        request
        expect(flash[:notice]).not_to be_empty
      end

      it 'does not contain alert flash message' do
        request
        expect(flash.now[:alert]).to be_nil
      end

      it 'assigns the requested contact to chat_group' do
        request
        expect(assigns(:chat_group)).to eq chat_group
      end

      it 'assigns the requested contact to chat_groups' do
        chat_groups = user.chat_groups
        request
        expect(assigns(:chat_groups)).to eq chat_groups
      end
    end

    context 'with an empty text attribute' do
      let(:request) { post :create, params: { chat_group_id: chat_group, message: attributes_for(:message, text: '', chat_group_id: chat_group.id, user_id: user.id) } }

      it 're-renders the :index template' do
        request
        expect(response).to render_template :index
      end

      it 'does not save the new contact' do
        expect{ request }.to_not change(Message,:count)
      end

      it 'contains alert flash message' do
        request
        expect(flash.now[:alert]).not_to be_empty
      end

      it 'does not contain notice flash message' do
        request
        expect(flash[:notice]).to be_nil
      end
    end
  end
end
