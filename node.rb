class  Node
  attr_reader :score, :name
  attr_accessor :left, :right

  def initialize(score, name)
    @score = score
    @name = name
    @left = nil
    @right = nil
  end
end
