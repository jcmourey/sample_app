require 'spec_helper'

describe "Session Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: I18n.t(:sign_in)) }
    it { should have_selector('title', text: I18n.t(:sign_in)) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button I18n.t(:sign_in) }

      it { should have_selector('title', text: I18n.t(:sign_in)) }
      it { should have_error_message(I18n.t :invalid_signin) }

      describe "after visiting another page" do
        before { click_link I18n.t(:home) }
        it { should_not have_error_message }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_selector('title', text: user.name) }
      it { should have_link(I18n.t :profile, href: user_path(user)) }
      it { should have_link(I18n.t :sign_out, href: signout_path) }
      it { should_not have_link(I18n.t :sign_in, href: signin_path) }
    end

  end

end
