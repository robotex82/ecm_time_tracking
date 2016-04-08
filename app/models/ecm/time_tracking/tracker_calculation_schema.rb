module Ecm::TimeTracking
  class TrackerCalculationSchema < ActiveRecord::Base
    module Defaults
      def self.included(base)
        base.after_initialize :set_defaults, if: :new_record?
      end

      def set_defaults
        self.enabled_from = '01.01.1900 00:00:00'
        self.enabled_to   = '31.12.9999 23:59:59'
      end
    end

    belongs_to :tracker, class_name: Configuration.tracker_class_name, foreign_key: 'tracker_id'

    validates :tracker, :identifier, :enabled_from, :enabled_to, presence: true

    include Defaults
    
    include Model::FlagFromTimeRangeConcern
    flag_from_time_range :enabled?
  end
end
