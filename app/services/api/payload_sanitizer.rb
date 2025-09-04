# frozen_string_literal: true

# Contains methods for sanitizing incoming API payloads
#
# Currently only handles stripping strings of leading/trailing whitespace.

class Api::PayloadSanitizer
  class << self
    # Strips the strings in passed object will modify the object in place.
    def strip_strings!(val)
      return strip_hash_values!(val) if val.is_a?(Hash)
      return strip_array_values!(val) if val.is_a?(Array)

      val.strip! if val.is_a?(String)
    end

    private

    def strip_hash_values!(hash)
      hash.each do |_key, val|
        strip_strings!(val)
      end
    end

    def strip_array_values!(arr)
      arr.each do |val|
        strip_strings!(val)
      end
    end
  end
end
