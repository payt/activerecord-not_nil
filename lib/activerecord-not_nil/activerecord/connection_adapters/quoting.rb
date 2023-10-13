# frozen_string_literal: true

module ActiveRecord
  module ConnectionAdapters
    module Quoting
      alias origin_type_cast type_cast
      def type_cast(value)
        raise ArgumentError, 'Cannot assign not_nil as a value' if value.is_a?(::NotNilClass)

        origin_type_cast(value)
      end
    end
  end
end
