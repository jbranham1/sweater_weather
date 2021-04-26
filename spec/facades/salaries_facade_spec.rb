require 'rails_helper'

RSpec.describe 'Salaries Facade'do
  describe 'get_salaries' do
    it 'can return the forecast and salaries of a destination' do
      destination = "denver"
      salaries = SalariesFacade.get_salaries(destination)

      expect(salaries).to be_a(Salaries)
      expect(salaries.destination).to eq(destination.titleize)
      expect(salaries.forecast).to be_a Hash
      expect(salaries.forecast).to have_key(:summary)
      expect(salaries.forecast[:summary]).to be_a String
      expect(salaries.forecast).to have_key(:temperature)
      expect(salaries.forecast[:temperature]).to be_a String

      expect(salaries.salaries).to be_an Array
      salary1 = salaries.salaries.first
      expect(salary1).to be_a Hash
      expect(salary1).to have_key(:title)
      expect(salary1[:title]).to be_a String
      expect(salary1).to have_key(:min)
      expect(salary1[:min]).to be_a String
      expect(salary1).to have_key(:max)
      expect(salary1[:max]).to be_a String
    end
  end
end
