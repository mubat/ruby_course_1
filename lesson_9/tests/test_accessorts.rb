# frozen_string_literal: true

require_relative "../accessors"

class Test1
  include Accessors

  attr_accessor_with_history :a, :var_b
end

test1 = Test1.new
test1.a = 1
if test1.a == 1
  puts "Variable returns expected value before change"
else
  puts "Error! Variable returns wrong value before change"
end

test1.a = 2
if test1.a == 2
  puts "Variable returns expected value after change"
else
  puts "Error! Variable returns wrong value after change"
end

test1.var_b = ""
test1.var_b = "test"
test1.var_b = 3
if test1.var_b == 3
  puts "Variable returns expected value of second param after changes"
else
  puts "Error! Variable returns wrong value of second param  after changes"
end
