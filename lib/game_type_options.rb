class GameTypeOptions
  HVH = "1"
  HVB = "2"
  BVH = "3"

  OPTION_TO_TYPE = {
    1 => "Human Vs Human",
    2 => "Human Vs Easy AI",
    3 => "Easy AI Vs Human"
  }

  def self.for_display
    formatted = OPTION_TO_TYPE.collect do |option, type|
      "#{type} (#{option})"
    end.join(" ; ")
  end

  def self.is_valid_game_type?(type)
    type = type.to_s
    type == HVH || type == HVB || type == BVH
  end
end
