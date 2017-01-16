class Recipe
  attr_reader :name, :description, :cooking_time, :difficulty

  def initialize(name, description, cooking_time, difficulty = "")
    @name = name
    @description = description
    @cooking_time = cooking_time
    @difficulty = difficulty
    @done = false
  end

  def mark_as_done!
    @done = true
  end

  def done?
    return @done
  end
end
