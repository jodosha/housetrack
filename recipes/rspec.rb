recipe :rspec do
  gem 'rspec-rails', '~> 2.7.0', :group => [:development,:test]
  generate 'rspec:install'
end

__END__

name: RSpec
description: "Use RSpec as testing framework."
author: RailsApps

category: testing
exclusive: test_framework
tags: [testing]
