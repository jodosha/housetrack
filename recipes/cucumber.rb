recipe :cucumber => :capybara do
  gem 'cucumber-rails', '1.2.3', :group => [:development, :test]

  generate "cucumber:install --capybara" do |command|
    command << ' --rspec' if config.test_framework.rspec?
    command << ' -D'  unless config.orm.active_record?
  end
end

__END__

name: Cucumber
description: "Use Cucumber for integration testing with Capybara."
author: jodosha

category: testing
exclusive: acceptance_testing
tags: [testing,acceptance]
