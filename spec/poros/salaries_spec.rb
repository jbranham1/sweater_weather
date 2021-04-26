require "rails_helper"

RSpec.describe Salaries do
  before :each do
    @location = "denver"
    @attrs = {
      :salaries=>
        [
          {:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"}, :salary_percentiles=>{:percentile_25=>42878.34161807408, :percentile_50=>51604.570316663645, :percentile_75=>62106.68549841864}},
          {:job=>{:id=>"DATA-SCIENTIST", :title=>"Data Scientist"}, :salary_percentiles=>{:percentile_25=>74686.71667078791, :percentile_50=>90222.6195047455, :percentile_75=>108990.21182279277}},
          {:job=>{:id=>"MOBILE-DEVELOPER", :title=>"Mobile Developer"}, :salary_percentiles=>{:percentile_25=>69999.26023545155, :percentile_50=>87546.87364822018, :percentile_75=>109493.37264132568}},
          {:job=>{:id=>"QA-ENGINEER", :title=>"QA Engineer"}, :salary_percentiles=>{:percentile_25=>56250.11944442941, :percentile_50=>69340.85682865855, :percentile_75=>85478.11939284134}},
          {:job=>{:id=>"SOFTWARE-ENGINEER", :title=>"Software Engineer"}, :salary_percentiles=>{:percentile_25=>64514.455607477714, :percentile_50=>78633.93395739446, :percentile_75=>95843.56732755537}},
          {:job=>{:id=>"SYSTEMS-ADMINISTRATOR", :title=>"Systems Administrator"}, :salary_percentiles=>{:percentile_25=>53889.29340697162, :percentile_50=>64856.55923374075, :percentile_75=>78055.82537282901}},
          {:job=>{:id=>"WEB-DEVELOPER", :title=>"Web Developer"}, :salary_percentiles=>{:percentile_25=>51218.21672136418, :percentile_50=>63464.58172585839, :percentile_75=>78639.07397537524}}
        ]
    }

    @salaries = Salaries.new(@attrs, @location)
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
    expect(@salary1).to have_key(:title)
    expect(@salary1[:title]).to be_a String
    expect(@salary1).to have_key(:min)
    expect(@salary1[:min]).to be_a String
    expect(@salary1).to have_key(:max)
    expect(@salary1[:max]).to be_a String
  end
  # describe 'get_credit' do
  #   it 'can return the credit from an salaries' do
  #     credit = @salaries.get_credit(@attrs[:results].first)
  #     expect(credit).to be_a Hash
  #     expect(credit).to have_key(:source)
  #     expect(credit[:source]).to be_a String
  #     expect(credit[:source]).to eq(@attrs[:results].first[:links][:html])
  #     expect(credit).to have_key(:author)
  #     expect(credit[:author]).to be_a String
  #     expect(credit[:author]).to eq(@attrs[:results].first[:user][:name])
  #     expect(credit).to have_key(:author_profile)
  #     expect(credit[:author_profile]).to be_a String
  #     expect(credit[:author_profile]).to eq(@attrs[:results].first[:user][:links][:html])
  #   end
  # end
end
