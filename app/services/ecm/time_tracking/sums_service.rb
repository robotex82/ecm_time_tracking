module Ecm
  module TimeTracking
    class SumsService < Itsf::Services::V2::Service::Base
      class Response < Itsf::Services::V2::Response::Base
        attr_accessor :overtime, :count_by_entry_type

        def overtime_in_hours
          overtime / 3600
        end
      end

      attr_accessor :entries, :overtime, :count_by_entry_type

      validates :entries, presence: true

      def do_work
        return response unless valid?
        calculate_sums
        response.overtime = overtime
        response.count_by_entry_type = count_by_entry_type
        response
      end

      private

      def calculate_sums
        @overtime = entries.map(&:overtime).reduce(0, :+)
        @count_by_entry_type = @entries.inject(Hash.new(0)) do |memo, entry|
          memo[entry.entry_type] += 1
          memo
        end
      end
    end
  end
end
