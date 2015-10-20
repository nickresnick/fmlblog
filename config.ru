# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require 'toto'

toto = Toto::Server.new do
  Toto::Paths = {
      :templates => "blog/templates",
      :pages => "blog/templates/pages",
      :articles => "blog/articles"
  }

  set :title, "My Blog"
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :summary,   :max => 500
  set :root, "blog"
end

app = Rails.new do
  use Rack::CommonLogger

  map '/blog' do
    run toto
  end

  map '/' do
    run Rails.application
  end
end.to_app

run app