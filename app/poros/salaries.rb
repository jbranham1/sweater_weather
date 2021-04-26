class Salaries
  attr_reader :id,
              :destination,
              :forecast,
              :salaries

  def initialize(salaries, forecast,destination)
    @id = nil
    @destination = destination.titleize
    @forecast = get_forecast(forecast)
    @salaries = get_salaries(salaries)
  end

  def get_forecast(forecast)
    {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp]} F"
    }
  end

  def get_salaries(salaries)
    job_titles = ["Data Analyst","Data Scientist","Mobile Developer",
            "QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
    job_titles.map do |job_title|
      job = salaries[:salaries].find { |job| job[:job][:title] == job_title}
      get_salary(job) if job
    end
  end

  def get_salary(job)
    {
      title: job[:job][:title],
      min: "$#{job[:salary_percentiles][:percentile_25].round(2)}",
      max: "$#{job[:salary_percentiles][:percentile_75].round(2)}"
    }
  end
end
