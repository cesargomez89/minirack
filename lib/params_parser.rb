class ParamsParser
  def initialize(params)
    @params = JSON.parse(params)
  end

  def require(keys = [])
    @keys = keys
    self
  end

  def valid?
    return true if @keys.empty?
    @params.keys & @keys == @keys
  end
end
