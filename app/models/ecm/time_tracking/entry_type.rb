module Ecm::TimeTracking
  class EntryType < ActiveRecord::Base
    validates :identifier, presence: true, uniqueness: true
    validates :due_in_seconds, presence: true

    def due_in_minutes=(due_in_minutes)
      self.due_in_seconds = due_in_minutes.to_i * 60
    end

    def due_in_minutes
      (due_in_seconds || 0) / 60
    end

    def due_in_hours=(due_in_hours)
      self.due_in_minutes = due_in_hours.to_i * 60
    end

    def due_in_hours
      (due_in_minutes || 0) / 60
    end


    def human
      identifier
    end
  end
end
