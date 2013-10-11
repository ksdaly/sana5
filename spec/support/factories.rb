FactoryGirl.define do
  factory :user do
    sequence (:username) {|n|"kate#{n}"}
    sequence (:email) {|n|"kate#{n}@example.com"}
    password '12345678'
  end

  factory :health_profile do
    user
    dob "1984-04-12"
    weight 140
    height 67
    systolic_bp 140
    diastolic_bp 90
    antihypertensive_drugs false
    steroid_drugs false
    male false
    smoker false
    diabetes false
    parent_with_diabetes false
    sibling_with_diabetes false
    exsmoker false
    cardiovascular_risk 1.34
    diabetes_risk 0.46
  end

  factory :health_plan do
    sequence (:title) {|n|"plan#{n}"}
    description 'minimize your risk'
    plan_length_days 21
  end

  factory :user_health_plan do
    user
    health_plan
    start_date {Date.today}
  end

  factory :to_do do
    health_plan
    sequence (:title) {|n|"to do #{n}"}
    description 'do this thing'
  end

  factory :user_to_do do
    user
    to_do
    completed false
    day { Time.now }
  end

end
