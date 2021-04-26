class SalariesFacade
  def self.get_salaries(destination)
    Salaries.new(destination)
  end
end
