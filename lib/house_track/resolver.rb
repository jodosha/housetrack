# CLEANME
# TESTME
module HouseTrack
  class Resolver
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def resolve!
      # info

      _run_callbacks(:processors) { resolve_processors }

      [
        _run_callbacks(:bundler)    { resolve_gems },
        _run_callbacks(:generators) { resolve_generators }
      ].flatten
    end

    def resolve_processors
      [
        resolve_recipe_processors,
        resolve_frameworks_processors
      ]
    end

    def resolve_recipe_processors
      _resolve_processors(:recipe_processors)
    end

    def resolve_frameworks_processors
      [
        resolve_orm_processors,
        resolve_test_framework_processors
      ]
    end

    def resolve_orm_processors
      _resolve_processors(:orm_processors)
    end

    def resolve_test_framework_processors
      _resolve_processors(:test_framework_processors)
    end

    def resolve_gems
      env.gems.map do |name, options|
        "gem '#{name}'".tap do |result|
          result << ", '#{options[:version]}'"   if options[:version]
          result << ", #{options[:options].inspect}" unless options[:options].empty?
        end
      end
    end

    def resolve_generators
      env.generators.map do |content, blk|
        rect = content.dup.tap do |result|
          result = blk.call(result).to_s if blk.respond_to?(:call)
        end
        "generate('#{rect}')"
      end
    end

    def info
      puts "recipes:        #{env.recipes.keys.join(', ')}\n"
      puts "gems:           #{env.gems.to_a.join(', ')}\n"
      puts "generators:     #{env.generators.to_a.join(', ')}\n"
      puts "recipe_processors: #{env.recipe_processors.keys.join(', ')}\n"
      puts "orm_processors: #{env.orm_processors.keys.join(', ')}\n"
      puts "test_framework_processors: #{env.test_framework_processors.keys.join(', ')}\n"
      puts "callbacks:      #{env.callbacks.keys.join(', ')}\n"
      puts "files:          #{env.files.keys.join(', ')}\n"
    end

    private
      def _resolve_processors(processors)
        env.send(processors).map do |recipe, blocks|
          if env.has_recipe?(recipe)
            blocks.map {|blk| env.recipe(recipe).instance_eval(&blk) }
          end
        end
      end

      def _run_callbacks(namespace, &block)
        [].tap do |result|
          result.push(_run_callbacks_for(namespace, :before))
          result.push(block.call)
          result.push(_run_callbacks_for(namespace, :after))
        end
      end

      def _run_callbacks_for(namespace, action)
        _callbacks_for(namespace, action).map {|cb| cb.call }
      end

      def _callbacks_for(namespace, action)
        if namespace = env.callbacks[namespace]
          namespace[action] || []
        else
          []
        end
      end
  end
end
