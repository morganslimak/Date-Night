require_relative 'node'

class BinarySearchTree
  attr_reader :root, :load

  def initialize
    @root = nil
    @sorted = []
  end

  def insert(score, name, node = @root, depth = 0)
    if @root == nil
      @root = Node.new(score, name)
      return depth
    elsif score < node.score && node.left == nil
      depth += 1
      node.left = Node.new(score, name)
      return depth
    elsif score > node.score && node.right == nil
      depth += 1
      node.right = Node.new(score, name)
      return depth
    elsif score < node.score && node.left != nil
      depth += 1
      insert(score, name, node.left, depth)
    elsif score > node.score && node.right != nil
      depth += 1
      insert(score, name, node.right, depth)
    end
  end

  def include?(score, node = @root)
    if score == node.score
      return true
    elsif score < node.score && node.left != nil
      include?(score, node.left)
    elsif score > node.score && node.right != nil
      include?(score, node.right)
    else
      return false
    end
  end

  def depth_of(score, node = @root, depth = 0)
    if score == node.score
      return depth
    elsif score < node.score && node.left != nil
      depth += 1
      depth_of(score, node.left, depth)
    elsif score > node.score && node.right != nil
      depth += 1
      depth_of(score, node.right, depth)
    else
      return nil
    end
  end

  def max(node=@root)
    if node.right == nil
      return {node.name => node.score}
    else
      max(node.right)
    end
  end

  def min(node=@root)
    if node.left == nil
      return {node.name => node.score}
    else
      min(node.left)
    end
  end

  def sort(node = @root)
    has_left_child(node)
  end

  def has_left_child(node)
    if node.left != nil
      has_left_child(node.left)
    else
      printer(node)
    end
  end

  def printer(node)
    if !@sorted.include?({node.name=>node.score})
      @sorted << {node.name => node.score}
    end
    has_right_child(node)
  end

  def has_right_child(node)
    if node.right != nil && !@sorted.include?({node.right.name => node.right.score})
      has_left_child(node.right)
    else
      load_parent(node)
    end
  end

  def parent_finder(score, node = @root)
    if score < node.score && node.left != nil
      if node.left.score == score
        return node
      else
        parent_finder(score, node.left)
      end
    elsif score > node.score && node.right != nil
      if node.right.score == score
        return node
      else
        parent_finder(score, node.right)
      end
    else
      return nil
    end
  end

  def load_parent(node)
    parent = parent_finder(node.score)
    already_printed(parent)
  end

  def already_printed(node)
    if @sorted.include?({node.name => node.score})
      if node == @root
        return @sorted
      else
        load_parent(node)
      end
    else
      printer(node)
    end
  end

  def load(file_name)
    count = 0
    File.foreach(file_name) do |movie|
      score = movie.split(", ")[0].chomp.to_i
      name = movie.split(", ")[1].chomp
      if @root == nil
        insert(score, name)
        count += 1
      elsif !include?(score)
        insert(score, name)
        count += 1
      end
    end
    return count
  end

end
