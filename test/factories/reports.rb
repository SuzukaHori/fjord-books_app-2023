# frozen_string_literal: true

FactoryBot.define do
  factory :first_report, class: Report do
    association :user
    id { 1 }
    title { '初日報です' }
    content { 'よろしくお願いします' }
  end

  factory :rails_report, class: Report do
    association :user, factory: :bob
    id { 2 }
    title { ' Rails難しい' }
    content { ' Rails難しい' }
  end
end
