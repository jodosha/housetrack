require 'yaml'

module HouseTrack
  class Recipe
    include HouseTrack::Dsl
    attr_reader :env, :name, :metadata

    def self.root
      @@root ||= File.expand_path('../../../recipes', __FILE__)
    end

    def self.load_recipes(recipes)
      Environment.new.tap do |env|
        recipes.flatten.each {|recipe| new(env, recipe) }
      end
    end

    def initialize(env, name)
      @env, @name = env, name
      load!
    end

    def load!
      instance_eval &eval("proc { #{_load_contents} }", binding)
    end

    def path
      "#{self.class.root}/#{name}.rb"
    end

    private
      def _load_contents
        result, metadata = File.new(path).read.split(/^__END__$/)
        _load_metadata(metadata)
        result
      end

      def _load_metadata(metadata)
        @metadata = YAML.load(metadata).to_hash
      end
  end
end
