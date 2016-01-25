class BoardOptions
  THREE_BY_THREE = 3

  def self.is_valid_dimension?(dimension)
    dimension.to_i == THREE_BY_THREE
  end
end
