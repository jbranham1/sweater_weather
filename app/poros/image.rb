class Image
  attr_reader :id,
              :location,
              :image_url,
              :description,
              :credit

  def initialize(data,location)
    @id = nil
    @location = location.titleize
    @image_url = data[:results].first[:urls][:regular]
    @description = data[:results].first[:description]
    @credit = get_credit(data[:results].first)
  end

  def get_credit(image_results)
    {
      source: image_results[:links][:html],
      author: image_results[:user][:name],
      author_profile: image_results[:user][:links][:html]
    }
  end
end
