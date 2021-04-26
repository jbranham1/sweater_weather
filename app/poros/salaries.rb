class Salaries
  attr_reader :id,
              :destination

  def initialize(destination)
    @id = nil
    @destination = destination.titleize
  end

  def forecast
    coords = MapquestService.find_coordinal_location(@destination)
    coords = coords[:results].first[:locations].first[:latLng]
    forecast = WeatherService.find_weather(coords)
    {
      summary: forecast[:current][:weather].first[:description],
      temperature: "#{forecast[:current][:temp]} F"
    }
  end

  def salaries
    sal = TeleportService.find_salaries(@destination.downcase)
    job_titles = ["Data Analyst","Data Scientist","Mobile Developer",
            "QA Engineer","Software Engineer","Systems Administrator","Web Developer"]
    job_titles.map do |job_title|
      job = sal[:salaries].find { |job| job[:job][:title] == job_title}
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
