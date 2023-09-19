FactoryBot.define do
  factory :suzuka, class: User do
    name {'suzuka'}
    email {'suzuka@example.com'}
    password {"password"}
  end

  factory :bob, class: User do
    name {'Bob'}
    email {'bob@example.com'}
    password {"password"}
  end

  factory :no_name, class: User do
    email {'no_name@example.com'}
    password {"password"}
  end
end
