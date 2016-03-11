require 'parslet'

# Parslet DSL extension for capturing the input source
class CaptureSource < Parslet::Atoms::Capture
  # Ugly hack to capture the source string that was parsed
  def apply(source, context, consume_all)
    before = source.instance_variable_get(:@str).rest
    success, value = result = super(source, context, consume_all)
    if success
      # Save the portion of the source string
      after = source.instance_variable_get(:@str).rest
      source_str = before[0..(before.length - after.length - 1)]
      value[(name.to_s + '_source').to_sym] = source_str
    end

    result
  end
end

# Modify named captures to allow arrays
class Parslet::Atoms::Named < Parslet::Atoms::Base
  def initialize(parslet, name, array = false)
    super()
    @parslet = parslet
    @name = name
    @array = array
  end

  private

  # Optionally wrap the produced single value in an array
  def produce_return_value(val)
    flatval = flatten(val, true)
    flatval = [flatval] if @array && val.last == [:repetition]
    { name => flatval }
  end
end

# Extend the DSL to with some additional ways to capture the output
module Parslet::Atoms::DSL
  # Like #as, but ensures that the result is always an array
  def as_array(name)
    Parslet::Atoms::Named.new(self, name, true)
  end

  # Capture some output along with the source string
  def capture_source(name)
    CaptureSource.new(self, name)
  end
end
