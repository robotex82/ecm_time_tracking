module Ecm
  module TimeTracking
    class SoftwareDeveloperSumsService < SumsService
      attr_accessor :gross_overtime_by_month
      attr_accessor :net_overtime_by_month

      def calculate_sums
        self.overtime = calculate_overtime
        self.count_by_entry_type = self.entries.inject(Hash.new(0)) do |memo, entry|
          memo[entry.entry_type] += 1
          memo
        end
      end

      def entries_by_month
        entries.group_by { |e| e.begin_at.beginning_of_month }
      end

      def calculate_overtime
        self.gross_overtime_by_month = self.entries_by_month.each_with_object({}) { |(month, entries), h| h[month] = entries.map(&:overtime).reduce(0, :+) }
        self.net_overtime_by_month = self.gross_overtime_by_month.each_with_object({}) { |(month, gross_overtime), h| h[month] = (overtime = (gross_overtime - included_monthly_overtime)) < 0 ? 0 : overtime }
        self.net_overtime_by_month.values.reduce(0, :+)
      end

      def included_monthly_overtime
        10 * 3600
      end
    end
  end
end
