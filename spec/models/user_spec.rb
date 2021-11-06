require 'rails_helper'

RSpec.describe User, type: :model do
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: "Aaron",
      last_name: "Sumner",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    expect(user).to be_valid

  end

  # 名がなければ無効な状態であること
  it "is invalid without a first name" do
    user = FactoryBot.build(:user,first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # 姓がなければ無効な状態であること
  it "is invalid without a last name" do
    user = FactoryBot.build(:user,last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address"do
    user = FactoryBot.build(:user,email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user,email: "aaron@example.com")
    user = FactoryBot.build(:user,email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user,first_name: "John",last_name: "Doe")
    expect(user.name).to eq "John Doe"
  end

  describe User do
    #有効なファクトリを持つこと
    it "has a avalid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  # 遅延ステータス
  describe "late status" do
    #締切日が過ぎていれば遅延していること
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project_due_yesterday)
      expect(project).to be_late
    end

    #締切日が今日ならスケジュール通りであること
    it "is on time when the due date is today" do
      project = FactoryBot.create(:project_due_today)
      expect(project).to_not be_late
    end

    #締切日が未来ならスケジュール通りであること
    it "is on time when the due date is the future" do
      project = FactoryBot.create(:project_due_tomorrow)
      expect(project).to_not be_late
    end
  end

end
