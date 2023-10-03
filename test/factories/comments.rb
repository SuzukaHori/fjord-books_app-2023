# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user
    association :commentable
    content { 'わかります' }
  end
end
