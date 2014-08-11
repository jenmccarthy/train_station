class Line

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
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
end
