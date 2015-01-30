FactoryGirl.define do
  factory :role do
    name Role::LIST.sample
    project
    association :user, factory: :normal_user
  end
end