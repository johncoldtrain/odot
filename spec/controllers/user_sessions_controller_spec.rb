require 'spec_helper'

describe UserSessionsController do

  # ----------------------------------
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end

  end # describe GET new



  # ============================>
  describe "POST 'create'" do

    #------------------------------------->>>
    context "with correct credentials" do

      let!(:user) { User.create(first_name: "Alex", 
                                last_name: "Romanillos", 
                                email: "alex@email.com", 
                                password: "password", 
                                password_confirmation: "password") 
      }

      it "redirects to the todo list path" do
        post :create, email: "alex@email.com", password: "password"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with( {email: "alex@email.com"} ).and_return(user)
        post :create, email: "alex@email.com", password: "password"
      end


      it "authenticates the user" do
        User.stub(:find_by).and_return(user) # Fix for test only
        expect(user).to receive(:authenticate)
        post :create, email: "alex@email.com", password: "password"
      end

      it "sets the user_id in the session" do
        post :create, email: "alex@email.com", password: "password"
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash success message" do
        post :create, email: "alex@email.com", password: "password"
        expect(flash[:success]).to eq("Thanks for logging in!")
      end

      # Added in Rails Layouts and CSS Frameworks course, for Rembember me branch
      it "sets the remember_me_token cookie if chosen" do
        expect(cookies).to_not have_key('remember_me_token')
        post :create, email: "alex@email.com", password: "password", remember_me: "1"
        expect(cookies).to have_key('remember_me_token')
        expect(cookies['remember_me_token']).to_not be_nil


      end

    end # context: with correct credentials




    #------------------------------------->>>
    context "with incorrect credentials" do


      # //////////////////////////////////
      shared_examples_for "denied login" do
        it "renders the new template" do
          post :create, email: email, password: password
          expect(response).to render_template('new')
        end

        it "sets the flash error message" do
          post :create, email: email, password: password
          expect(flash[:error]).to eq("There was a problem loggin in. Please check your email and password.")
        end

      end # shared_examples_for "denied login"
      # //////////////////////////////////



      # ---------------------->
      context "with blank credentials" do
        let(:email) { "" }
        let(:password) { "" }
        it_behaves_like "denied login"

      end # context: with blank credentials


      # ---------------------->
      context "with an incorrect password" do
        let!(:user) { User.create(first_name: "Alex", 
                                  last_name: "Romanillos", 
                                  email: "alex@email.com", 
                                  password: "password", 
                                  password_confirmation: "password") 
        }

        let(:email) { user.email }
        let(:password) { "wrong" }
        it_behaves_like "denied login"

      end # context: with an incorrect password


      # ---------------------->
      context "with a non existent email" do
        let!(:user) { User.create(first_name: "Alex", 
                                  last_name: "Romanillos", 
                                  email: "alex@email.com", 
                                  password: "password", 
                                  password_confirmation: "password") 
        }

        let(:email) { "someemail@email.com" }
        let(:password) { "wrong" }
        it_behaves_like "denied login"

      end # context: with an incorrect password


    end # with incorrect credentials

  end # describe POST create


  describe "DELETE destroy" do
    context "logged in" do
      before do
        sign_in create(:user)
      end

      it "returns a redirect" do
        delete :destroy
        expect(response).to be_redirect
      end

      it "sets the flash message" do
        delete :destroy
        expect(flash[:notice]).to_not be_blank
        expect(flash[:notice]).to match(/logged out/)
      end

      it "removes the session[:user_id] key" do
        session[:user_id] = 1
        delete :destroy
        expect(session[:user_id]).to be_nil
      end

      # / / / Cookie Removal / / / 
      it "removes the remember_me_token cookie" do
        cookies['remember_me_token'] = 'remembered'
        delete :destroy
        expect(cookies).to_not have_key('remember_me_token')
        expect(cookies['remember_me_token']).to be_nil
      end
      

      it "resets the session" do
        expect(controller).to receive(:reset_session)
        delete :destroy
      end

    end # context logged in

  end # DELETE destroy

end







