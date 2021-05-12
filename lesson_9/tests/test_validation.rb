# frozen_string_literal: true

require_relative "../validation"

class Foo
  include Validation

  attr_accessor :bar, :baz
end

foo = Foo.new
foo.bar = "234234"
if foo.validate(:bar, :format, /^\d+$/)
  puts "Validation works fine, Validator 'format' returns correct result"
else
  puts "Error! Validation doesn't work or validator 'format' returns incorrect result"
end

foo.bar = "test string with 123 number"
if foo.validate(:bar, :format, /^\d+$/)
  puts "Error! validator 'format' returns incorrect result when format doesn't match"
else
  puts "Validator 'format' returns correct result when format doesn't match "
end

if foo.validate(:bar, :presence)
  puts "Validator 'presence' returns correct result for not empty value"
else
  puts "Error! validator 'presence' returns incorrect result for not empty value"
end

foo.bar = ""
if foo.validate(:bar, :presence)
  puts "Error! validator 'presence' returns incorrect result for empty value"
else
  puts "Validator 'presence' returns correct result for empty value"
end

foo.baz = ""
if foo.validate(:baz, :type, String)
  puts "Validator 'type' returns correct result"
else
  puts "Error! validator 'type' returns incorrect result"
end

foo.baz = 1
if foo.validate(:baz, :type, Integer)
  puts "Validator 'type' returns correct result"
else
  puts "Error! validator 'type' returns incorrect result"
end
