module HouseTrack
  class Config < Hash
    def initialize(frameworks)
      merge!(frameworks)
    end

    def orm
      _inquiry(self['orm'] || 'active_record')
    end

    def template_engine
      _inquiry(self['template_engine'] || 'erb')
    end

    def test_framework
      _inquiry(self['test_framework'] || 'test_unit')
    end

    def fixture_replacement
      _inquiry(self['fixture_replacement'])
    end

    def acceptance_testing
      _inquiry(self['acceptance_testing'])
    end

    private
      def _inquiry(string)
        StringInquirer.new(string.to_s)
      end
  end
end
