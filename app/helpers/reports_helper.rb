# frozen_string_literal: true

module ReportsHelper
  def create_report_id_array(text)
    text.scan(%r{http://localhost:3000/reports/(\d+)}).map { |ids| ids[0] }
  end
end
