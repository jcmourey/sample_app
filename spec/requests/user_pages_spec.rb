require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: I18n.t(:sign_up)) }
    it { should have_selector('title', text: full_title(I18n.t :sign_up)) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "signup" do
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button I18n.t(:create_account) }.not_to change(User, :count)
      end

      describe "error_messages" do
        before { click_button I18n.t(:create_account) }

        it { should have_selector('title', text: I18n.t(:sign_up)) }
        it { should have_content(I18n.t :error) }
        it { should_not have_content('password digest') }
      end
    end

    describe "with valid information" do
      before do
        fill_in I18n.t(:name, scope: [:activerecord, :attributes, :user]),         with: "Example User"
        fill_in 'user_password',     with: "foobar"
        fill_in 'user_email',        with: "user@example.com"
        fill_in I18n.t(:confirmation), with: "foobar"
      end

      it "should create a user" do
        expect { click_button I18n.t(:create_account) }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button I18n.t(:create_account) }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: I18n.t(:welcome_new_user)) }
        it { should have_link(I18n.t(:sign_out)) }

        describe "followed by signout" do
          before { click_link I18n.t(:sign_out) }
          it { should have_link(I18n.t :sign_in) }
        end

      end
    end
  end

end
