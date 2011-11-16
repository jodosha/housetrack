recipe :carrierwave do
  with_orm :mongoid do
    gem 'carrierwave-mongoid', '~> 0.1.3', :require => 'carrierwave/mongoid'
  end
end

__END__

name: Carrierwave
description: "Use the Carrierwave as uploader."
author: jodosha

category: upload
tags: [upload]
