require 'test_helper'

describe HouseTrack::Recipe do
  def setup
    @env  = HouseTrack::Environment.new
    @name = 'mongoid'
  end

  describe "load_recipes" do
    it "should load recipes and return an environment instance" do
      env = HouseTrack::Recipe.load_recipes([@name])
      env.must_be_instance_of(HouseTrack::Environment)
    end
  end

  describe "#initialize" do
    before do
      @recipe = HouseTrack::Recipe.new(@env, @name)
    end

    it "should load contents" do
      @recipe.env.must_equal(@env)
      @recipe.name.must_equal(@name)
      @recipe.metadata['category'].must_equal('persistence')
    end

    it "should register in the environment" do
      assert @env.has_recipe?(@name)
      @env.config.orm.must_equal(@name)
    end
  end
end
