class GameType
  HVH = "1"
 
  def self.is_valid_game_type?(type)
    type.to_s == HVH
  end
end
