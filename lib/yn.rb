class YN 
  Y = "1"
  N = "2"

  def self.is_valid_choice?(choice)
    choice.to_s == Y || choice.to_s == N 
  end
end
