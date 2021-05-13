# frozen_string_literal: true

require_relative "../accessors"

class Test1
  include Accessors

  attr_accessor_with_history :a, :var_b
  attr_accessor :else_var
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

if test1.var_b_history.instance_of?(Array)
  puts "Can get history values"
else
  puts "Error! Can't get history values"
end

if test1.var_b_history == ["", "test", 3]
  puts "Variable has correct history values"
else
  puts "Error! Variable doesn't have correct history values. [ER] #{['', 'test',
                                                                     3].inspect}, [AR] #{test1.var_b_history}"
end

test1.else_var = "some_value"
if test1.else_var && test1.else_var == "some_value"
  puts "Default attr_accessor works fine"
else
  puts "Error! Something damaged at default attr_accessor's work"
end

class Test2
  include Accessors

  strong_attr_accessor :strong_attr_string, String
  strong_attr_accessor :strong_attr_array, Array
end

test2 = Test2.new
begin
  test2.strong_attr_string = "test"
  if test2.strong_attr_string == "test"
    puts "Strong attribute has correct value after populate"
  else
    puts "Error! Strong attribute has incorrect value after populate. [ER] 'test' [AR] '#{test2.strong_attr_string}'"
  end
rescue TypeError => e
  puts "Error! Can't set value with correct type. Error: #{e}"
end

begin
  test2.strong_attr_array = "test"
  if test2.strong_attr_array == "test"
    puts "Error! Strong attribute has incorrect value after populate. " \
         "[ER] raise TypeError [AR] '#{test2.strong_attr_array}'"
  else
    puts "Error! Can't populate value with incorrect value, " \
         "but excpeption not raise. Value: '#{test2.strong_attr_array}'"
  end
rescue TypeError => e
  puts "Strong attribute raise TypeError with message '#{e}' on populating value with wrong type"
end
