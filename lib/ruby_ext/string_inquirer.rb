# Borrowed from ActiveSupport
# https://github.com/rails/rails/blob/master/activesupport/lib/active_support/string_inquirer.rb
class StringInquirer < String
  def method_missing(method_name, *arguments)
    if method_name.to_s[-1,1] == "?"
      self == method_name.to_s[0..-2]
    else
      super
    end
  end
end
