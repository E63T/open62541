module Open62541
    class Variant
        property variant = LibOpen62541::UaVariant.new

        def initialize
            # Nothing
        end

        def finalize
            LibOpen62541.ua_clear pointerof(@variant), LibOpen62541.ua_types + LibOpen62541::UA_TYPES_VARIANT
        end

        def to_unsafe
            pointerof(@variant)
        end

        private def has_scalar_type?(tp)
            @variant.array_length == 0 && @variant.data > Pointer(Void).new(1) && tp == @variant.type
        end

        private def as_type?(typeid : Int32, type : T.class) forall T
            if has_scalar_type? LibOpen62541.ua_types + typeid
                @variant.data.as(Pointer(T)).value
            else
                nil
            end
        end

        {% for k, v in {
            "bool" => {Bool, :UA_TYPES_BOOLEAN},
            "u8" => {UInt8, :UA_TYPES_BYTE},
            "i8" => {Int8, :UA_TYPES_SBYTE},
            "u16" => {UInt16, :UA_TYPES_UINT16},
            "i16" => {Int16, :UA_TYPES_INT16}
        } %}
            def as_{{k.id}}
                value = as_{{k.id}}?
                raise "Cannot convert variant to #{ {{k}} }" if value.nil?
                value.not_nil!
            end

            def as_{{k.id}}?
                as_type? LibOpen62541::{{v.last.id}}, {{v.first}}
            end
        {% end %}
    end
end