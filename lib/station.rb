class Station

  attr_reader(:name, :location, :id)

  def initialize(attributes)
    @name = attributes['name']
    @location = attributes['location']
    @id = attributes['id'].to_i
  end

  def self.all
    stations = []
    results = DB.exec("SELECT * FROM stations;")
    results.each do |result|
      current_station = Station.new(result)
      stations << current_station
    end
  stations
  end

  def save
    results = DB.exec("INSERT INTO stations (name, location) VALUES ('#{@name}', '#{@location}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(other_station)
    @name == other_station.name && @location == other_station.location && @id == other_station.id
  end
end
