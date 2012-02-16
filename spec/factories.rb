FactoryGirl.define do

  factory :user do
    sequence( :first_name) { |n| "Testy#{n}"}
    sequence( :last_name) { |n| "McTesterson#{n}" }
    sequence( :email) {|n| "testy#{n}@gunpowder.ucsd.edu" }
    password "123456"
    password_confirmation "123456"
  end

  factory :document do
    sequence(:file_name) { |n| "document_#{n}" }
    after_create { |document| Factory(:project, :documents => [document])}
  end

  factory :project do
    sequence(:project_name) { |n| "project_#{n}" }
    description "Some Cool Project"
    after_create { |project| Factory(:corpus, :projects => [project] )}
  end

  factory :corpus do
    sequence(:name) { |n| "corpus_#{n}" }
    description "A bunch of Media"
  end
end
