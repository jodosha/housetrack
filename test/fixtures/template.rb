# create fresh git repo
git :init
git :add    => '.'
git :commit => '-a -m "New Rails app created with House Track"'

# gems
gem 'mongoid',                '~> 2.3.1'
gem 'bson_ext',               '~> 1.4.0'
gem 'devise',                 '~> 1.4.5'
gem 'cancan',                 '~> 1.6.7'
gem 'haml',                   '~> 3.1.3'
gem 'twitter-bootstrap-rails' # TODO
gem 'carrierwave-mongoid',    '~> 0.1.3', :require => 'carrierwave/mongoid'
gem 'haml-rails',             '~> 0.3.4', :group => :development
gem 'factory_girl_rails',     '~> 1.3.0', :group => :test
gem 'mongoid-rspec',          '~> 1.4.4', :group => :test
gem 'cucumber'
# gem 'database_cleaner',       '~> 0.6.7', :group => :test
gem 'capybara',               '~> 1.1.1', :group => [:development,:test]
gem 'rspec-rails',            '~> 2.7.0', :group => [:development,:test]
gem 'guard-rspec',            '~> 0.5.0', :group => [:development,:test]

# generators
generate 'mongoid:config'
generate 'rspec:install'
generate 'devise:install'
generate 'devise', 'user' # 'user' cames from the question

# patches
gsub_file 'app/models/user.rb', /end/ do
  %Q{
    field :name
    validates_presence_of :name
    validates_uniqueness_of :name, :email, :case_sensitive => false
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  }
end

insert_into_file 'app/assets/javascripts/application.js',  "//= require twitter/bootstrap\n", :after => "jquery_ujs\n"
insert_into_file 'app/assets/stylesheets/application.css', " *= require twitter/bootstrap\n", :after => "require_self\n"

gsub_file "app/views/layouts/application.html.haml", /App_Name/, "#{app_name.humanize.titleize}"

# commit template results to repo
git :commit => '-a -m "Applied application template"'