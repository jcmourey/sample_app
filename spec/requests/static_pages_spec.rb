require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text:  heading)    }
    it { should have_selector('title', text: full_title(page_title)) }

  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { I18n.t(:App_Name) }
    let(:page_title) { '' }
		it_should_behave_like "all static pages"
		it { should_not have_selector('title', text: "| ${I18n.t :home}") }
	end

	describe "Help page" do
    before { visit help_path }
    let(:heading)    { I18n.t :help }
    let(:page_title) { I18n.t :help }
    it_should_behave_like "all static pages"
  end

	describe "About page" do
    before { visit about_path }
    let(:heading)    { I18n.t :about }
    let(:page_title) { I18n.t :about }
    it_should_behave_like "all static pages"
  end

	describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { I18n.t :contact }
    let(:page_title) { I18n.t :contact }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link I18n.t(:about)
    page.should have_selector 'title', text: full_title(I18n.t :about_us)
    click_link I18n.t(:help)
    page.should have_selector 'title', text: full_title(I18n.t :help)
    click_link I18n.t(:contact)
    page.should have_selector 'title', text: full_title(I18n.t :contact)
    click_link I18n.t(:home)
    click_link I18n.t(:sign_up)
    page.should have_selector 'title', text: full_title(I18n.t :sign_up)
    click_link I18n.t(:app_name)
    page.should have_selector 'title', text: full_title('')
  end
end