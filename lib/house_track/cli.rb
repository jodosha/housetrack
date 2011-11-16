require 'thor'
require 'house_track'

module HouseTrack
  class Cli < Thor
    desc 'new', "Generate a new Rails application template, by applying recipes."
    method_options :recipes => :array
    def new
      puts _generate_recipe(_load_recipes(options[:recipes]))
    end

    private
      def _load_recipes(recipes)
        HouseTrack::Recipe.load_recipes(recipes)
      end

      def _generate_recipe(env)
        HouseTrack::Resolver.new(env).resolve!
      end
  end

  CLI = Cli
end
