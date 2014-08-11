class Station
  def initialize(attributes)
    @name = attributes['name']
    @location = attributes['location']
    @id = attributes['id'].to_i
  end
end
