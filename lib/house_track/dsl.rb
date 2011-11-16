module HouseTrack
  module Dsl
    def recipe(name, &block)
      # TODO resolve recipe :cucumber => :capybara
      env.register_recipe(name, self)
      block.call
    end

    def with_recipe(name, &block)
      env.register_recipe_processor(name, block)
    end

    def with_orm(name, &block)
      env.register_orm_processor(name, block)
    end

    def with_test_framework(name, &block)
      env.register_test_framework_processor(name, block)
    end

    def gem(*args)
      options = args.extract_options!
      name, version = args

      env.register_gem(name, version, options)
    end

    def generate(content, &block)
      env.register_generator(content, block)
    end

    def config
      env.config
    end

    # Callbacks
    def before_bundler(&block)
      env.register_callback(:bundler, :before, block)
    end

    def after_generators(&block)
      env.register_callback(:generators, :after, block)
    end

    # TODO
    def create_file(*)
    end

    # TODO
    def gsub_file(*)
    end

    # TODO
    def git(*)
    end

    # TODO
    def yes?(*)
    end
  end
end
