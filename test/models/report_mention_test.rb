# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  test 'save_mentions' do
    report = users(:suzuka).reports.create!(title: 'test', content: '日報1')
    assert_equal [], report.mentioning_reports.ids

    report = users(:suzuka).reports.create!(title: 'test', content: 'http://localhost:3000/reports/2')
    assert_equal [2], report.mentioning_reports.ids
  end
end
