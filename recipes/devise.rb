recipe :devise do
  gem 'devise', '~> 1.4.5'
  generate 'devise:install'

  # if yes?('Would you like to install Devise user?')
  #   model_name = ask('What would you like the user model to be called? [user]')
  #   model_name = 'user' if model_name.blank?
  #   generate('devise', model_name)
  # end

  with_orm :mongoid do
    gsub_file 'app/models/user.rb', /end/ do
      %Q{
        field :name
        validates_presence_of :name
        validates_uniqueness_of :name, :email, :case_sensitive => false
        attr_accessible :name, :email, :password, :password_confirmation, :remember_me
      }
    end
  end
end

__END__

name: Devise
description: Utilize Devise for authentication, automatically configured for your selected ORM.
author: jodosha

category: authentication
tags: [authentication]
