require 'test_helper'

class Receipt
  include HouseTrack::Dsl
  attr_reader :env

  def initialize(env)
    @env = env
  end
end

describe HouseTrack::Dsl do
  def setup
    @env     = mock()
    @block   = Proc.new {}
    @receipt = Receipt.new(@env)
  end

  describe "#with_recipe" do
    it "should register processor" do
      @receipt.env.expects(:register_recipe_processor).with(:capybara, @block)
      @receipt.with_recipe(:capybara, &@block)
    end
  end

  describe "#with_orm" do
    it "should register processor" do
      @receipt.env.expects(:register_orm_processor).with(:mongoid, @block)
      @receipt.with_orm(:mongoid, &@block)
    end
  end

  describe "#with_test_framework" do
    it "should register processor" do
      @receipt.env.expects(:register_test_framework_processor).with(:rspec, @block)
      @receipt.with_test_framework(:rspec, &@block)
    end
  end

  describe "#gem" do
    describe "when passed with name" do
      it "should register" do
        @receipt.env.expects(:register_gem).with('redis-store', nil, {})
        @receipt.gem('redis-store')
      end
    end

    describe "when passed with name and version" do
      it "should register" do
        @receipt.env.expects(:register_gem).with('redis-store', '1.0.0', {})
        @receipt.gem('redis-store', '1.0.0')
      end
    end

    describe "when passed with name and options" do
      it "should register" do
        @receipt.env.expects(:register_gem).with('redis-store', nil, { :git => 'git://github.com/jodosha/redis-store.git'})
        @receipt.gem('redis-store', :git => 'git://github.com/jodosha/redis-store.git')
      end
    end

    describe "when passed with name, version and options" do
      it "should register" do
        @receipt.env.expects(:register_gem).with('redis-store', '1.0.0', { :git => 'git://github.com/jodosha/redis-store.git'})
        @receipt.gem('redis-store', '1.0.0', :git => 'git://github.com/jodosha/redis-store.git')
      end
    end
  end

  describe "#generate" do
    describe "when passed with content" do
      it "should register generator" do
        @receipt.env.expects(:register_generator).with('devise:install', nil)
        @receipt.generate('devise:install')
      end
    end

    describe "when passed with content and block" do
      it "should register generator" do
        @receipt.env.expects(:register_generator).with('devise:install', @block)
        @receipt.generate('devise:install', &@block)
      end
    end
  end

  describe "#before_bundler" do
    it "should register callback" do
      @receipt.env.expects(:register_callback).with(:bundler, :before, @block)
      @receipt.before_bundler(&@block)
    end
  end

  describe "#after_generators" do
    it "should register callback" do
      @receipt.env.expects(:register_callback).with(:generators, :after, @block)
      @receipt.after_generators(&@block)
    end
  end
end
