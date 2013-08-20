require 'spec_helper'

describe Grade do
  company = FactoryGirl.create(:company)

  it "generates a number score for the company" do
    expect(company.calculate_rating).to eq(100)
  end

  it "generates a letter grade for the company" do
    expect(company.assign_letter_grade).to eq("A")
  end

end
