# frozen_string_literal: true

require_relative "../validation"

class Foo
  include Validation

  attr_accessor :bar
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
