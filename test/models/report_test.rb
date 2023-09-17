# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?(target_user)' do
    own_report = users(:suzuka).reports.create!(title: 'test', content: 'test')
    assert_equal true, own_report.editable?(users(:suzuka))

    others_report = users(:bob).reports.create!(title: 'test', content: 'test')
    assert_equal false, others_report.editable?(users(:suzuka))
  end
end
