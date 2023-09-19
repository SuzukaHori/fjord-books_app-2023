# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as_suzuka
    @report = FactoryBot.create(:first_report, user: @user)
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'チーム開発'
    fill_in '内容', with: 'もうすぐ終わります'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'チーム開発'
    assert_text 'もうすぐ終わります'
  end

  test 'should show Report' do
    visit report_url(@report)
    assert_text '初日報です'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '初日報！！！'
    fill_in '内容', with: '初めまして、よろしくお願いします'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '初日報！！！'
    assert_text '初めまして、よろしくお願いします'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end
