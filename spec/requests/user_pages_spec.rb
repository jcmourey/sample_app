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
        expect { click_button I18n.t(:submit) }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in I18n.t(:name, scope: [:activerecord, :attributes, :user]),         with: "Example User"
        fill_in I18n.t(:email, scope: [:activerecord, :attributes, :user]),        with: "user@example.com"
        fill_in I18n.t(:password, scope: [:activerecord, :attributes, :user]),     with: "foobar"
        fill_in I18n.t(:confirmation), with: "foobar"
      end

      it "should create a user" do
        expect { click_button I18n.t(:submit) }.to change(User, :count).by(1)
      end
    end
  end

end
