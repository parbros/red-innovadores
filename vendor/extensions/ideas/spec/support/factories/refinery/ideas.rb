
FactoryGirl.define do
  factory :idea, :class => Refinery::Ideas::Idea do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

