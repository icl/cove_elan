FactoryGirl.define do

  factory :user do
    sequence( :first_name) { |n| "Testy#{n}"}
    sequence( :last_name) { |n| "McTesterson#{n}" }
    sequence( :email) {|n| "testy#{n}@gunpowder.ucsd.edu" }
    password "123456"
    password_confirmation "123456"
  end

  factory :document do
		eaf { File.open(File.join(Rails.root, 'spec', 'fixtures', '02_09.eaf')) }
  end

  factory :project do
    sequence(:project_name) { |n| "project_#{n}" }
    description "Some Cool Project"
		association(:corpus)
  end

  factory :project_with_work, :class => Project do
    sequence(:project_name) { |n| "project_#{n}" }
    description "Some Cool Project"
		association(:corpus)
    association(:document)
  end

  factory :corpus do
    sequence(:name) { |n| "corpus_#{n}" }
    description "A bunch of Media"
  end

  factory :corpus_with_work, :class => Corpus do
    sequence(:name) { |n| "corpus_#{n}" }
    description "A bunch of Media"
    association(:document)
  end


	factory :work_document do
		association(:document)
		association(:project)
	end
end
