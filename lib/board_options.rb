class BoardOptions
  THREE = 3

  def self.is_valid_dimension?(dimension)
    dimension.to_i == THREE
  end
end
