class Station

  attr_reader(:name, :location, :id)

  def initialize(attributes)
    @name = attributes['name']
    @location = attributes['location']
    @id = attributes['id'].to_i
  end

  def self.all
    stations = []

    stations
  end
end
