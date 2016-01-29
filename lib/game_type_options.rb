class GameTypeOptions
  HVH = "1"
  HVB = "2"
  BVH = "3"

  OPTION_TO_TYPE = {
    1 => "Human Vs Human",
    2 => "Human Vs Easy AI",
    3 => "Easy AI Vs Human"
  }

  def self.is_valid_game_type?(type)
    type_string = type.to_s
    type_string == HVH || type_string == HVB || type_string == BVH
  end

  def self.for_display
    formatted = OPTION_TO_TYPE.collect do |option, type_description|
      option_for_display(option, type_description) 
    end.join(" ; ")
  end

  def self.option_for_display(option, type_description)
    "#{type_description} (#{option})"
  end
end
