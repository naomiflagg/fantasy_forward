FactoryBot.define do
  factory :team do
    name { Faker::Team.state }
    code { rand(30) }
  end

  factory :player do
    first_name { Faker::Name.male_first_name }
    last_name { Faker::Name.unique.last_name }
    position { %w[Goalkeeper Defender Midfielder Forward].sample }
    points { rand(90) }
    goals { rand(30) }
    assists { rand(30) }
    clean_sheets { rand(20) }
    prediction { rand(90) }
    team
  end
end
