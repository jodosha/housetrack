require 'test_helper'

describe HouseTrack::Config do
  describe "#initialize" do
    it "should retain given configuration" do
      config = HouseTrack::Config.new('orm' => :mongoid, 'test_framework' => :rspec)
      config.keys.must_equal(['orm', 'test_framework'])
    end
  end

  describe "#orm" do
    describe "with value" do
      it "should return value" do
        config = HouseTrack::Config.new('orm' => :mongoid)
        assert config.orm.mongoid?
      end
    end

    describe "without value" do
      it "should return default value" do
        config = HouseTrack::Config.new({})
        assert config.orm.active_record?
      end
    end
  end

  describe "#template_engine" do
    describe "with value" do
      it "should return value" do
        config = HouseTrack::Config.new('template_engine' => :haml)
        assert config.template_engine.haml?
      end
    end

    describe "without value" do
      it "should return default value" do
        config = HouseTrack::Config.new({})
        assert config.template_engine.erb?
      end
    end
  end

  describe "#test_framework" do
    describe "with value" do
      it "should return value" do
        config = HouseTrack::Config.new('test_framework' => :rspec)
        assert config.test_framework.rspec?
      end
    end

    describe "without value" do
      it "should return default value" do
        config = HouseTrack::Config.new({})
        assert config.test_framework.test_unit?
      end
    end
  end

  describe "#fixture_replacement" do
    describe "with value" do
      it "should return value" do
        config = HouseTrack::Config.new('fixture_replacement' => :factory_girl)
        assert config.fixture_replacement.factory_girl?
      end
    end
  end

  describe "#acceptance_testing" do
    describe "with value" do
      it "should return value" do
        config = HouseTrack::Config.new('acceptance_testing' => :cucumber)
        assert config.acceptance_testing.cucumber?
      end
    end
  end
end
