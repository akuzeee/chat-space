require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    context 'with logged in user' do
      context 'when current_user belongs to @chat_group' do
        it "renders the :index template" do
        end

        it "assigns the requested contact to @chat_group" do
        end

        it "assigns the requested contact to @chat_groups" do
        end

        it "assigns the requested contact to @message" do
        end
      end

      context 'when current_user does not belongs_to @chat_group' do
        it 'redirects to chat_groups/:index' do
        end
      end
    end
    context 'without logged in user' do
      it "redirects to devise/sessions/:new " do
      end
    end
  end

  describe 'POST #create' do
  end
end
