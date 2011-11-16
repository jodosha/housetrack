recipe :mongoid do
  gem 'bson_ext', '~> 1.4.0'
  gem 'mongoid',  '~> 2.3.1'

  with_test_framework :rspec do
    gem 'mongoid-rspec', '~> 1.4.4', :group => :test
  end

  generate 'mongoid:config'
end

__END__

name: Mongoid
description: "Utilize MongoDB with Mongoid as the ORM."
author: jodosha

category: persistence
exclusive: orm
tags: [orm, mongodb]
