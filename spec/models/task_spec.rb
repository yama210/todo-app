require "rails_helper"

RSpec.describe Task, type: :model do
  it "inherits from ApplicationRecord" do
    expect(described_class).to be < ApplicationRecord
  end

  it "requires text" do
    task = described_class.new(text: "")

    expect(task).not_to be_valid
    expect(task.errors[:text]).to be_present
  end
end
