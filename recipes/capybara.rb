recipe :capybara do
  gem 'capybara', :group => [:development, :test]

  create_file 'spec/support/capybara.rb', \
    %Q{
      require 'capybara/rails'
      require 'capybara/rspec'
      }

  create_file 'spec/requests/home_spec.rb', \
    %Q{
      require 'spec_helper'

      describe 'visiting the homepage' do
        before do
          visit '/'
        end

        it 'should have a body' do
          page.should have_css('body')
        end
      end
      }
end

__END__

name: Capybara
description: "Use the Capybara acceptance testing libraries with RSpec."
author: jodosha

category: testing
exclusive: acceptance_testing
tags: [testing,acceptance]
