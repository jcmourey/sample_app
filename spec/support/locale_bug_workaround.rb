# Specify locale otherwise RSpec will choke on xxx_path methods
# (e.g. user_path(user) will pass user inside :locale parameter)
# only necessary because of the use of scope "(/:locale)" in routes.rb
# source: https://github.com/rspec/rspec-rails/issues/255
class ActionView::TestCase::TestController
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end

class ActionDispatch::Routing::RouteSet
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end