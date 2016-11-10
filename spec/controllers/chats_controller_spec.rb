require "rails_helper"

describe ChatsController do
  describe "GET #index" do
    it "assigns the requested contact to @message" do
      get :index
      expect(assigns(:message)).to be_a_new Message
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    context "success" do
      it "save the new message in the database" do
        expect {
          post :create, message: attributes_for(:message)
        }.to change( Message, :count).by(1)
      end
      it "redirects to chats#index" do
          post :create, message: attributes_for(:message)
          expect(response).to redirect_to chats_path
      end
      it "don't define flash[:notice]" do
        post :create, message: attributes_for(:message)
        expect(flash[:notice]).to be_nil
      end
    end

    context "failure" do
      it "can't save the new message in the database" do
        expect {
          post :create, message: attributes_for(:message,body: nil)
        }.to change( Message, :count).by(0)
      end
      it "redirect to chats#index" do
        post :create, message: attributes_for(:message, body: nil)
        expect(response).to redirect_to chats_path
      end
      it "define flash[:notice]" do
        post :create, message: attributes_for(:message, body: nil)
        expect(flash[:notice]).not_to be_nil
      end
    end
  end
end
