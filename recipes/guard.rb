recipe :guard do
  # if yes?('Would you like to guard your test suite?')
    with_recipe :rspec do
      gem 'guard-rspec', '~> 0.5.0', :group => [:development,:test]
    end
  # end
end

__END__

name: guard
description: "Automate your workflow with Guard"
author: jodosha

category: other
tags: [development]

