class Line

  attr_reader :name, :id, :join_id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
    @join_id = nil
  end

  def self.all
    lines = []
    results = DB.exec("SELECT * FROM lines;")
    results.each do |result|
      current_line = Line.new(result)
      lines << current_line
    end
    lines
  end

  def save
    results = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_line)
    @name == another_line.name && @id == another_line.id
  end

  def edit_name(new_name)
    @name = new_name
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM lines WHERE id = #{@id};")
  end

  def add_to_line(input_station)
    results = DB.exec("INSERT INTO lines_stations (line_id, station_id) VALUES ('#{@id}', '#{input_station.id}') RETURNING id;")
    @join_id = results.first['id'].to_i
  end

  def list_stations
    stations = []
    results = DB.exec("SELECT * FROM lines_stations WHERE line_id = #{@id};")
    results.each do |result|
      station_id = result['station_id'].to_i
      station_rows = DB.exec("SELECT * FROM stations WHERE id = #{station_id};")
      station_rows.each do |station_row|
        stations << Station.new(station_row)
      end
    end
    stations
  end

  def get_pairs
    output = []
    results = DB.exec("SELECT * FROM lines_stations;")
    results.each do |result|
      ids = []
      ids << result['id'].to_i
      ids << result['line_id'].to_i
      ids << result['station_id'].to_i
      output << ids
    end
    output
  end

end
