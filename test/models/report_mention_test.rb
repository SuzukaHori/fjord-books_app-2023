# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  test 'save_mentions' do
    user = FactoryBot.create(:suzuka)

    report = user.reports.create!(title: 'メンションなしの日報', content: '今日も楽しく勉強した')
    assert_equal [], report.mentioning_reports.ids

    report = user.reports.create!(title: '1にメンションした日報', content: 'http://localhost:3000/reports/1')
    assert_equal [1], report.mentioning_reports.ids
  end
end
