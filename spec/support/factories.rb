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
  end
end
