FactoryGirl.define do

  factory :user do
    sequence( :first_name) { |n| "Testy#{n}"}
    sequence( :last_name) { |n| "McTesterson#{n}" }
    sequence( :email) {|n| "testy#{n}@gunpowder.ucsd.edu" }
    password "123456"
    password_confirmation "123456"
  end

end
