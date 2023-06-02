# frozen_string_literal: true

require 'not_nil'

module Arel
  module Visitors
    module NotNilOverride
      def visit_Arel_Nodes_Equality(o, collector)
        return super unless o.right.value.value.is_a?(NotNil::NotNilClass)

        collector = visit o.left, collector
        collector << " IS NOT NULL"
      end
    end

    class ToSql < Arel::Visitors::Visitor
      prepend NotNilOverride
    end
  end
end

module ActiveRecord
  module ConnectionAdapters
    # module NotNullOverride
    # def quote(value)
    #   return "NOT NULL" if value == not_nil

    #   super
    # end
    # end

    module Quoting
      # prepend NotNullOverride

      alias origin_type_cast type_cast
      def type_cast(value)
        raise ArgumentError, "Cannot assign not_nil as a value" if value.is_a?(NotNil::NotNilClass)

        origin_type_cast(value)
      end
    end
  end
end
