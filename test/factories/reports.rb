FactoryBot.define do
  factory :first_report, class: Report do
    association :user
    id {1}
    title {'初日報です'}
    content {'よろしくお願いします'}
  end

# second_report:
#   id: 2
#   user: bob
#   title: Rails難しい
#   content: 時間がかかりそうです。
end
