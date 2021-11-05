FactoryBot.define do
  factory :project do
    sequence(:name) { |n|"Project #{n}" }
    description {"Sample project for testing purposes"}
    due_on {1.week.from_now}
    association :owner
  end

  # 昨日が締め切りのプロジェクト
  factory :project_due_yesterday,class:Project do
    sequence(:name) { |n|"Test Project #{n}" }
    description {"Sample project for testing purposes"}
    due_on {1.day.ago}
    association :owner
  end
end
