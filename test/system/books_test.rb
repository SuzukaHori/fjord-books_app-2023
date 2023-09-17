# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)
    visit new_user_session_path
    fill_in 'Eメール', with: 'suzuka@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'わかりやすいです'
    fill_in '著者', with: 'igaiga'
    click_on '登録する'

    assert_text '本が作成されました'
    assert_text 'Ruby超入門'
    assert_text 'わかりやすいです'
    assert_text 'igaiga'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集'

    fill_in 'タイトル', with: 'プロを目指す人のためのRuby入門 改訂版'
    fill_in 'メモ', with: '改訂されました'
    fill_in '著者', with: 'Junichi Ito'
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'プロを目指す人のためのRuby入門 改訂版'
    assert_text '改訂されました'
    assert_text 'Junichi Ito'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除'

    assert_text '本が削除されました。'
  end
end
