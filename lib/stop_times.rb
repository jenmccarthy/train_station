class Times

  attr_reader :stop_id, :times

  def initialize(attributes)
    @stop_id = attributes['stop_id'].to_i
    @times = attributes['times']
  end

end
