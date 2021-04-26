class TeleportService
  def self.find_salaries(destination)
    conn_string = "slug%3A#{destination}/salaries/"
    response = connection.get(conn_string)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'https://api.teleport.org/api/urban_areas/')
  end
end
