# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  test 'save_mentions' do
    user = FactoryBot.create(:suzuka)
    FactoryBot.create(:first_report, user:)

    assert_no_difference 'ReportMention.count' do
      user.reports.create!(title: 'メンションなしの日報', content: '今日も楽しく勉強した')
    end

    assert_difference 'ReportMention.count', 1 do
      user.reports.create!(title: '1にメンションした日報', content: 'http://localhost:3000/reports/1')
    end
  end
end
