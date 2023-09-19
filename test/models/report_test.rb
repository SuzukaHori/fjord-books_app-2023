# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?(target_user)' do
    suzuka = create(:suzuka)
    bob = create(:bob)

    own_report = suzuka.reports.create!(title: 'test', content: 'test')
    assert_equal true, own_report.editable?(suzuka)

    others_report = bob.reports.create!(title: 'test', content: 'test')
    assert_equal false, others_report.editable?(suzuka)
  end
end
