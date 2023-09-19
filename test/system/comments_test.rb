# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    sign_in_as_suzuka
    @report = FactoryBot.create(:rails_report)
  end

  test 'should create comment' do
    visit report_url(@report)
    fill_in 'comment[content]', with: '良い日報ですね'
    click_on 'コメントする'

    assert_text 'コメントが作成されました。'
    assert_text '良い日報ですね'
  end

  test 'should destroy comment' do
    visit report_url(@report)
    fill_in 'comment[content]', with: '削除のためのコメント'
    click_on 'コメントする'
    assert_text 'コメントが作成されました。'
    click_on '削除'
    page.accept_alert
    assert_text 'コメントが削除されました。'
  end
end
