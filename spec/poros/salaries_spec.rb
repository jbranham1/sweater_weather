require "rails_helper"

RSpec.describe Salaries do
  before :each do
    @location = "denver"
    @jobs = {
      salaries: [
        {:job=>{:id=>"DATA-ANALYST", :title=>"Data Analyst"},:salary_percentiles=>{:percentile_25=>42878.34161807408, :percentile_50=>51604.570316663645, :percentile_75=>62106.68549841864}},
        {:job=>{:id=>"DATA-SCIENTIST", :title=>"Data Scientist"},:salary_percentiles=>{:percentile_25=>74686.71667078791, :percentile_50=>90222.6195047455, :percentile_75=>108990.21182279277}},
      ]
    }
    @forecast = {
      current: {
        temp: 70.2,
        weather: [{description: 'description'}]
      }
    }
    @salaries = Salaries.new(@jobs, @forecast, @location)
  end
  it "exists" do
    expect(@salaries).to be_a Salaries
    expect(@salaries.id).to eq(nil)
    expect(@salaries.destination).to be_a String
    expect(@salaries.destination).to eq(@location.titleize)
    expect(@salaries.forecast).to be_a Hash
    expect(@salaries.forecast).to have_key(:summary)
    expect(@salaries.forecast[:summary]).to be_a String
    expect(@salaries.forecast[:summary]).to eq(@forecast[:current][:weather].first[:description])
    expect(@salaries.forecast).to have_key(:temperature)
    expect(@salaries.forecast[:temperature]).to be_a String
    expect(@salaries.forecast[:temperature]).to eq("#{@forecast[:current][:temp]} F")

    expect(@salaries.salaries).to be_an Array
    salary1 = @salaries.salaries.first
    expect(salary1).to have_key(:title)
    expect(salary1[:title]).to be_a String
    expect(salary1[:title]).to eq(@jobs[:salaries].first[:job][:title])
    expect(salary1).to have_key(:min)
    expect(salary1[:min]).to be_a String
    expect(salary1[:min]).to eq("$#{@jobs[:salaries].first[:salary_percentiles][:percentile_25].round(2)}")
    expect(salary1).to have_key(:max)
    expect(salary1[:max]).to be_a String
    expect(salary1[:max]).to eq("$#{@jobs[:salaries].first[:salary_percentiles][:percentile_75].round(2)}")
  end

  describe "get_forecast" do
    it "returns summary and temperature of forecast" do
      forecast = @salaries.get_forecast(@forecast)
      expect(forecast).to be_a Hash
      expect(forecast).to have_key(:summary)
      expect(forecast[:summary]).to be_a String
      expect(forecast[:summary]).to eq(@forecast[:current][:weather].first[:description])
      expect(forecast).to have_key(:temperature)
      expect(forecast[:temperature]).to be_a String
      expect(forecast[:temperature]).to eq("#{@forecast[:current][:temp]} F")
    end
  end
  describe "get_salaries" do
    it "returns summary and temperature of forecast" do
      salaries = @salaries.get_salaries(@jobs)
      expect(salaries).to be_an Array
      salary1 = salaries.first
      expect(salary1).to have_key(:title)
      expect(salary1[:title]).to be_a String
      expect(salary1[:title]).to eq(@jobs[:salaries].first[:job][:title])
      expect(salary1).to have_key(:min)
      expect(salary1[:min]).to be_a String
      expect(salary1[:min]).to eq("$#{@jobs[:salaries].first[:salary_percentiles][:percentile_25].round(2)}")
      expect(salary1).to have_key(:max)
      expect(salary1[:max]).to be_a String
      expect(salary1[:max]).to eq("$#{@jobs[:salaries].first[:salary_percentiles][:percentile_75].round(2)}")
    end
  end
  describe "get_salary_information" do
    it "returns summary and temperature of forecast" do
      job = @salaries.get_salary_information(@jobs[:salaries].first)
      expect(job).to have_key(:title)
      expect(job[:title]).to be_a String
      expect(job[:title]).to eq(@jobs[:salaries].first[:job][:title])
      expect(job).to have_key(:min)
      expect(job[:min]).to be_a String
      expect(job[:min]).to eq("$#{@jobs[:salaries].first[:salary_percentiles][:percentile_25].round(2)}")
      expect(job).to have_key(:max)
      expect(job[:max]).to be_a String
      expect(job[:max]).to eq("$#{@jobs[:salaries].first[:salary_percentiles][:percentile_75].round(2)}")
    end
  end
end
