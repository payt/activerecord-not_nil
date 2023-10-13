# frozen_string_literal: true

module Arel
  module Visitors
    module NotNilOverride
      def visit_Arel_Nodes_Equality(o, collector)
        return super if o.right.is_a?(Arel::Attributes::Attribute)

        binding.pry if o.right.is_a?(Arel::Nodes::NamedFunction)
        return super if o.right.is_a?(Arel::Nodes::NamedFunction)
        return super unless o.right.value.is_a?(::NotNilClass)

        collector = visit o.left, collector
        collector << ' IS NOT NULL'
      end
    end

    class ToSql < Arel::Visitors::Visitor
      prepend NotNilOverride
    end
  end
end
