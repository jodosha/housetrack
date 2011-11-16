module HouseTrack
  class Environment
    attr_accessor :gems, :recipes, :generators,
      :recipe_processors, :orm_processors, :test_framework_processors,
      :callbacks, :files, :exclusive, :frameworks

    def initialize
      @gems                      = {}
      @recipes                   = {}
      @generators                = {}

      @recipe_processors         = {}
      @orm_processors            = {}
      @test_framework_processors = {}

      @callbacks                 = {}
      @files                     = {}

      @exclusive                 = {}
      @frameworks                = {}
    end

    def config
      HouseTrack::Config.new(@frameworks)
    end

    def has_recipe?(recipe)
      recipes.has_key?(recipe.to_sym)
    end

    def recipe(name)
      recipes[name]
    end

    def register_recipe(name, recipe)
      _register_recipe_metadata(name, recipe.metadata)
      recipes[name] = recipe
    end

    def register_recipe_processor(recipe, block)
      recipe = recipe.to_sym
      recipe_processors[recipe] ||= []
      recipe_processors[recipe].push(block)
    end

    def register_orm_processor(orm, block)
      orm = orm.to_sym
      orm_processors[orm] ||= []
      orm_processors[orm].push(block)
    end

    def register_test_framework_processor(test_framework, block)
      test_framework = test_framework.to_sym
      test_framework_processors[test_framework] ||= []
      test_framework_processors[test_framework].push(block)
    end

    def register_gem(name, version, options = nil)
      gems[name] = Hash[:version => version, :options => options]
    end

    def register_generator(content, block = nil)
      generators[content] = block
    end

    def register_callback(namespace, action, block)
      namespace, action = namespace.to_sym, action.to_sym
      callbacks[namespace] ||= {}
      callbacks[namespace][action] ||= []
      callbacks[namespace][action].push(block)
    end

    def register_file(path, content)
      files[path] = content
    end

    private
      def _register_recipe_metadata(name, metadata)
        _register_exclusive(      metadata['exclusive'])
        _register_framework(name, metadata['exclusive'])
      end

      def _register_exclusive(category)
        return if category.nil?

        if exclusive.has_key?(category)
          raise ExclusiveCategoryViolation.new(self, category)
        end

        exclusive[category] = true
      end

      def _register_framework(name, framework)
        frameworks[framework] = name unless framework.nil?
      end
  end
end
