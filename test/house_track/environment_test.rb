require 'test_helper'

describe HouseTrack::Environment do
  def setup
    @block = Proc.new { 'Hello!' }
    @env   = HouseTrack::Environment.new
  end

  describe "#initialize" do
    it "should initialize registers" do
      @env.gems.must_equal({})
      @env.recipes.must_equal({})
      @env.generators.must_equal({})

      @env.recipe_processors.must_equal({})
      @env.orm_processors.must_equal({})
      @env.test_framework_processors.must_equal({})

      @env.callbacks.must_equal({})
      @env.files.must_equal({})

      @env.exclusive.must_equal({})
      @env.frameworks.must_equal({})
    end
  end

  describe "#config" do
    it "should instantiate a config object" do
      @env.config.must_be_instance_of(HouseTrack::Config)
    end
  end

  describe "#register_recipe_processor" do
    it "should register" do
      @env.register_recipe_processor(:capybara, @block)
      @env.recipe_processors[:capybara].must_equal([@block])
    end
  end

  describe "#register_orm_processor" do
    it "should register" do
      @env.register_orm_processor(:mongoid, @block)
      @env.orm_processors[:mongoid].must_equal([@block])
    end
  end

  describe "#register_test_framework_processor" do
    it "should register" do
      @env.register_test_framework_processor(:rspec, @block)
      @env.test_framework_processors[:rspec].must_equal([@block])
    end
  end

  describe "#register_gem" do
    describe "when passed with name" do
      it "should register" do
        @env.register_gem('redis-store', nil)
        @env.gems['redis-store'].must_equal(Hash[:version => nil, :options => nil])
      end
    end

    describe "when passed with name and version" do
      it "should register" do
        @env.register_gem('redis-store', '1.0.0')
        @env.gems['redis-store'].must_equal(Hash[:version => '1.0.0', :options => nil])
      end
    end

    describe "when passed with name and options" do
      it "should register" do
        @env.register_gem('redis-store', nil, :git => 'git://github.com/jodosha/redis-store.git')
        @env.gems['redis-store'].must_equal(Hash[:version => nil, :options => { :git => 'git://github.com/jodosha/redis-store.git' }])
      end
    end

    describe "when passed with name, version and options" do
      it "should register" do
        @env.register_gem('redis-store', '1.0.0', :git => 'git://github.com/jodosha/redis-store.git')
        @env.gems['redis-store'].must_equal(Hash[:version => '1.0.0', :options => { :git => 'git://github.com/jodosha/redis-store.git' }])
      end
    end
  end

  describe "#register_generator" do
    describe "when passed with string" do
      it "should register" do
        @env.register_generator('devise:install')
        assert @env.generators.has_key?('devise:install')
      end
    end

    describe "when passed with string and block" do
      it "should register" do
        @env.register_generator('devise:install', @block)
        # @env.generators['devise:install'].must_equal(@block)
      end
    end
  end

  describe "#register_callback" do
    it "should register" do
      @env.register_callback(:bundler, :before, @block)
      @env.callbacks[:bundler][:before].must_equal([@block])
    end
  end

  describe "#register_file" do
    it "should register" do
      @env.register_file('/path/to/file', 'Hello, World!')
      @env.files['/path/to/file'].must_equal('Hello, World!')
    end
  end
end
