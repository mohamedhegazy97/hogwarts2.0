FactoryBot.define do
  factory :User do 
    name {"Michael Example"}
    email {"michael1.0@example.com"}
    password_digest { User.digest('password') }
    admin {true}
    birth_date {"1997-02-02"}
    ARMU {false}
    bio {""}
  end
end