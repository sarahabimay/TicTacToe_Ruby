class Mark
  X = "X"
  O = "O"

  def Mark.is_a_mark?(mark)
    mark == X || mark == O
  end
end
