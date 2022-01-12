module Open62541
    class NodeID
        property id = LibOpen62541::UaNodeId.new
        getter name : String = ""

        def to_unsafe
            @id
        end

        def initialize(nsidx : UInt16, @name : String)
            id.namespace_index = nsidx
            id.identifier_type = LibOpen62541::UaNodeIdType::UaNodeidtypeString
            id.identifier.string.length = @name.bytesize
            id.identifier.string.data = @name.to_unsafe
        end

        def initialize(nsidx : UInt16, name : UInt16)
            id.namespace_index = nsidx
            id.identifier_type = LibOpen62541::UaNodeIdType::UaNodeidtypeNumeric
            id.identifier = name
            @name = name.to_s
        end
    end
end