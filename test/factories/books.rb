# frozen_string_literal: true

FactoryBot.define do
  factory :cherry_book, class: Book do
    id { 1 }
    title { 'プロを目指す人のためのRuby入門' }
    memo { '名著です！' }
  end

  factory :code_book, class: Book do
    id { 2 }
    title { 'リーダブルコード' }
    memo { '感動した' }
  end
end
