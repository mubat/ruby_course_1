# frozen_string_literal: true

require_relative "../validation"

class Foo
  include Validation

  attr_accessor :bar, :baz

  validate :bar, :format, /^\d+$/
  validate :bar, :presence
  validate :baz, :type, String

  def initialize
    # create object with valid values on start
    @bar = '1232345'
    @baz = 'some string'
  end
end

foo = Foo.new
if foo.valid?
  puts "'valid?' works fine, Validator 'format' returns correct result."
else
  begin
    puts "Error! 'validate!' returns boolean, but valid?' returns false" if foo.validate!
  rescue ValidationError => e
    puts "Error! 'valid?' doesn't work or validator 'format' returns incorrect result. Error: #{e}"
  end
end

begin
  if Foo.new.validate!
    puts "'validate!' works fine"
  else
    puts "Error! 'validate!' doesn't work. Returns false"
  end
rescue ValidationError
  puts "Error! 'validate!' doesn't work. Raise ValidationError"
end

foo = Foo.new
foo.bar = "test string with 123 number"
if foo.valid?
  puts "Error! Method 'valid?' returns incorrect result when format doesn't match"
else
  puts "Method 'valid?' returns correct result when format doesn't match "
end

foo = Foo.new
foo.baz = nil
begin
  result = foo.validate!
  if result
    puts "Error! 'validate!' doesn't work. [ER] Raise ValidationError [AR] #{result}"
  end
rescue ValidationError
  puts "'validate!' works fine. Raise ValidationError"
end


foo = Foo.new
foo.bar = nil
if foo.valid?
  puts "Error! validator 'presence' returns incorrect result for nil value"
else
  puts "Validator 'presence' returns correct result for nil value"
end

foo = Foo.new
foo.bar = ""
if foo.valid?
  puts "Error! validator 'presence' returns incorrect result for empty String value"
else
  puts "Validator 'presence' returns correct result for empty String value"
end

foo = Foo.new
foo.baz = ""
if foo.valid?
  puts "Validator 'type' returns correct result"
else
  puts "Error! validator 'type' returns incorrect result"
end


foo = Foo.new
foo.baz = 1
if foo.valid?
  puts "Error! validator 'type' returns incorrect result"
else
  puts "Validator 'type' returns correct result"
end
