FactoryGirl.define do

  sequence(:email) {|n| "user.#{n}@domain.com" }
  sequence(:username) {|n| "username#{n}" }
  sequence(:q_auth_uid) {|n| (n*100) }

  factory :user do

    name "First Middle Last"
    username
    email

    phone "123-456-7890"
    skype "skype"
    linkedin "Linked In"

    city "Mysore"
    state "Karnataka"
    country "India"

    q_auth_uid

    auth_token {SecureRandom.hex}
    token_created_at {Time.now}
  end

  factory :normal_user, parent: :user do
    biography "A programmer by profession. A student of history and music by passion. Uses Ruby, Python and Javascript. Work as an Web Architect for Qwinix"
    department "department"
    designation "designation"
    user_type "user"
  end

  factory :admin_user, parent: :user do
    user_type "admin"
  end

  factory :super_admin_user, parent: :user do
    user_type "super_admin"
  end

end
