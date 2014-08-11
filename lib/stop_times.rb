class Times

  def initialize(attributes)
    @stop_id = attributes['stop-id'].to_i
    @times = attributes['times']
  end

end
