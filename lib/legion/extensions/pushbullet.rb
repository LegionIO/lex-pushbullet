require 'legion/extensions/pushbullet/version'

module Legion
  module Extensions
    module Pushbullet
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
