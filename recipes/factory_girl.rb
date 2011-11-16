recipe :factory_girl do
  gem 'factory_girl_rails', '~> 1.3.0', :group => :test

  with_test_framework :test_unit do
    #generators.fixture_replacement :factory_girl, :dir => 'test/factories'
  end

  with_test_framework :rspec do
    #generators.fixture_replacement :factory_girl, :dir => 'spec/factories'
  end
end

__END__

name: FactoryGirl
description: Utilize FactoryGirl as fixture replacement, automatically configured for your selected testing framework.
author: jodosha

category: fixtures
exclusive: fixture_replacement
tags: [testing,fixtures]
