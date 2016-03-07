require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Ecm
  module TimeTracking
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :tracker_class_name do
        nil
      end
    end
  end
end
