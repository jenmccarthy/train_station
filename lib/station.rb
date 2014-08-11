class Station

  attr_reader(:name, :location, :id)

  def initialize(attributes)
    @name = attributes['name']
    @location = attributes['location']
    @id = attributes['id'].to_i
    # @join_id = nil
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

  def edit_name(input_name)
    @name = input_name
    results = DB.exec("UPDATE stations SET name = '#{@name}' WHERE id = '#{self.id}';")
  end

  def edit_location(input_location)
    results = DB.exec("UPDATE stations SET location = '#{input_location}' WHERE id = '#{self.id}';")
    @location = input_location
  end

  def delete
    DB.exec("DELETE FROM stations WHERE id = '#{self.id}';")
  end

  # def add_to_line(input_line)
  #   results = DB.exec("INSERT INTO lines_stations (line_id, station_id) VALUES ('#{input_line.id}', '#{@id}') RETURNING id;")
  #   @join_id = results.first['id'].to_i
  # end
end
