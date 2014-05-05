# Binary Serch Tree implementation in Ruby
# * Insert 
# * Min
# * Max
# * Delete
# * Storage and read
class Node
  # Represent the left and right branches of the node
  attr_accessor :left, :right, :value

  # init the node with a single value
  def initialize(value)
    @value = value
  end

  def insert(new_node)
    if @value > new_node.value
      insert_into(:left, new_node)
    elsif @value < new_node.value
      insert_into(:right, new_node)
    else
      # Value is the same as current node
    end
  end

  def min
    if @left.nil?
      @value
    else
      @left.min
    end
  end

  def max 
    if @right.nil?
      @value
    else
      @right.max
    end
  end

  #
  # Format: [VALUE, LEFT, RIGHT]
  #
  def print
    "[#{@value},#{@left ? @left.print : "nil"},#{@right ? @right.print : "nil"}]"
  end

  # Read in from string
  def self.read tree
    unless tree.nil?
      node_value, left_sub, right_sub = Node.extract tree
      main_node = Node.new node_value
      main_node.read_sub :left, left_sub
      main_node.read_sub :right, right_sub
      main_node
    end
  end

  def self.extract tree
    tree = eval(tree) if tree.kind_of?(String)
    tree
  end

  def read_sub direction, tree
    new_node = Node.read tree
    self.instance_variable_set :"@#{direction.to_s}", new_node
  end

  private 
  def insert_into(direction, new_node)
    child_node = self.send(direction)
    if child_node.nil?
      self.instance_variable_set :"@#{direction.to_s}", new_node
    else
      child_node.insert new_node
    end
  end
end


# TEST
start = rand(30)
puts "Starting with #{start}"

A = Node.new start
10.times.each do |i|
  n = rand(100)
  puts "Inserting #{n}"
  A.insert Node.new n
end

puts "======="
puts "tree: #{A.print}"
puts "min: #{A.min}"
puts "max: #{A.max}"

puts "======="
tree = "[21,[17,nil,nil],[81,[62,[58,[31,nil,[36,nil,nil]],nil],[77,[68,nil,nil],nil]],[82,nil,[91,nil,nil]]]]"
puts "Read from stream: \n#{tree}"
B = Node.read tree
puts B.print

