module Ecm::TimeTracking
  class Entry < ActiveRecord::Base
    DEFAULT_DUE_HOURS_PER_DAY = 8
    DEFAULT_BREAK_LENGTH_IN_MINUTES = 45

    belongs_to :tracker, class_name: Configuration.tracker_class_name, foreign_key: 'tracker_id'
    belongs_to :entry_type

    validates :tracker, :begin_at, :end_at, presence: true

    after_initialize :set_defaults, if: :new_record?

    def break_length_in_minutes=(break_length_in_minutes)
      self.break_length_in_seconds = break_length_in_minutes.to_i * 60
    end

    def break_length_in_minutes
      (break_length_in_seconds || 0) / 60
    end

    def length
      end_at - begin_at
    end

    def overtime
      length - due_in_seconds - (break_length_in_seconds || 0)
    end

    def due_in_seconds
      entry_type.try(:due_in_seconds) || 0
    end

    private

    def set_defaults
      self.end_at = Time.zone.now.change(sec: 0)
      self.begin_at = self.end_at - DEFAULT_DUE_HOURS_PER_DAY.hours - DEFAULT_BREAK_LENGTH_IN_MINUTES.minutes
      self.break_length_in_minutes = DEFAULT_BREAK_LENGTH_IN_MINUTES
    end
  end
end
