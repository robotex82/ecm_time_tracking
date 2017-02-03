require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'

module Ecm
  module TimeTracking
    module Configuration
      def configure
        yield self
      end

      mattr_accessor(:tracker_class_name) {}
      mattr_accessor(:default_calculation_schema) { 'Ecm::TimeTracking::FlatSumsService' }
    end
  end
end
