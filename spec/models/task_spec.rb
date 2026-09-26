require "rails_helper"

RSpec.describe Task, type: :model do
  it "inherits from ApplicationRecord" do
    expect(described_class).to be < ApplicationRecord
  end
end
