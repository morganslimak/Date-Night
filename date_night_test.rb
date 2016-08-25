gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'date-night'

class NetflixTest < Minitest::Test
  def test_insert_root_node
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal "Bill & Ted's Excellent Adventure", tree.root.name
  end

  def test_root_node_has_depth
    tree = BinarySearchTree.new
    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
  end

  def test_root_node_has_left_and_right
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    assert_equal "Johnny English", tree.root.left.name
    assert_equal "Sharknado 3", tree.root.right.name
  end

  def test_inserting_next_depth_of_nodes
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    tree.insert(7, "I Love You Phillip Morris")
    tree.insert(86, "Charlie's Angels")
    assert_equal 50, tree.root.left.right.score
    assert_equal 7, tree.root.left.left.score
    assert_equal 86, tree.root.right.left.score
  end

  def test_depth_returning_on_insertion
    tree = BinarySearchTree.new
    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 1, tree.insert(92, "Sharknado 3")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 3, tree.insert(41, "Love")
  end

  def test_check_if_tree_includes_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    tree.insert(41, "Love")
    assert tree.include?(16)
    refute tree.include?(72)
    assert tree.include?(41)
    refute tree.include?(99)
  end

  def test_depth_of_method_returns_depth
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal 1, tree.depth_of(92)
    assert_equal 2, tree.depth_of(50)
    assert_equal nil, tree.depth_of(99)
  end

  def test_return_highest_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal ({"Sharknado 3"=>92}), tree.max
  end

  def test_return_lowest_score
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal ({"Johnny English"=>16}), tree.min
  end

  def test_parent_finder
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(41, "Love")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal "Love", tree.parent_finder(50).name
  end

  def test_sort_by_traversing_tree
    tree = BinarySearchTree.new
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(41, "Love")
    tree.insert(50, "Hannibal Buress: Animal Furnace")
    assert_equal ({"Johnny English"=>16}), tree.sort[0]
    assert_equal ({"Love"=>41}), tree.sort[1]
    assert_equal ({"Hannibal Buress: Animal Furnace"=>50}), tree.sort[2]
    assert_equal ({"Bill & Ted's Excellent Adventure"=>61}), tree.sort[3]
    assert_equal ({"Sharknado 3"=>92}), tree.sort[4]
  end

  def test_load_a_txt_file
    tree = BinarySearchTree.new
    assert_equal 54, tree.load('movies.txt')
  end

  def test_sort_with_loaded_file
    tree = BinarySearchTree.new
    tree.load('movies.txt')
    assert_equal 54, tree.sort.length
    assert_equal ({"Cruel Intentions"=>0}), tree.sort[0]
    assert_equal ({"The Little Engine That Could"=>100}), tree.sort[-1]
  end

end
