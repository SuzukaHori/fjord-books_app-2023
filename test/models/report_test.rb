# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?(target_user)' do
    suzuka = FactoryBot.create(:suzuka)
    bob = FactoryBot.create(:bob)

    own_report = suzuka.reports.create!(title: 'test', content: 'test')
    assert own_report.editable?(suzuka)

    others_report = bob.reports.create!(title: 'test', content: 'test')
    assert_not others_report.editable?(suzuka)
  end
end
