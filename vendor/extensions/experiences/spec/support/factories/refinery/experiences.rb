
FactoryGirl.define do
  factory :experience, :class => Refinery::Experiences::Experience do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

