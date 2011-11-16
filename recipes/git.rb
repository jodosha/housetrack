recipe :git do
  before_bundler do
    git :init
    git :add    => '.'
    git :commit => '-a -m "New Rails app created with House Track"'
  end

  after_generators do
    git :commit => '-a -m "Applied application template"'
  end
end

__END__

name: Git
description: "Provides basic Git setup for the Rails app and commits the initial repository."
author: jodosha

category: other
exclusive: scm
tags: [scm]

