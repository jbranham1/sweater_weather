require "rails_helper"

RSpec.describe Salaries do
  before :each do
    @location = "denver"
    @salaries = Salaries.new(@location)
  end
  it "exists" do
    expect(@salaries).to be_a Salaries
    expect(@salaries.id).to eq(nil)
    expect(@salaries.destination).to be_a String
    expect(@salaries.destination).to eq(@location.titleize)
    expect(@salaries.forecast).to be_a Hash
    expect(@salaries.forecast).to have_key(:summary)
    expect(@salaries.forecast[:summary]).to be_a String
    expect(@salaries.forecast).to have_key(:temperature)
    expect(@salaries.forecast[:temperature]).to be_a String
    expect(@salaries.salaries).to be_an Array
    
    salary1 = @salaries.salaries.first
    expect(salary1).to have_key(:title)
    expect(salary1[:title]).to be_a String
    expect(salary1).to have_key(:min)
    expect(salary1[:min]).to be_a String
    expect(salary1).to have_key(:max)
    expect(salary1[:max]).to be_a String
  end
end
