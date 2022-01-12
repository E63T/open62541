module Open62541
    class Client
        property client : LibOpen62541::UaClient

        def wrap(&)
            sc = yield
            if sc != LibOpen62541::UA_STATUSCODE_GOOD
                raise UAException.new sc
            end
            sc
        end

        def initialize(url : String)
            @client = LibOpen62541.ua_client_new

            if @client.null?
                raise "Failed to allocate UA Client"
            end

            wrap { LibOpen62541.ua_client_connect @client, url }
        end

        def finalize
            LibOpen62541.ua_client_delete @client
        end
        
        def read_value_attribute(node : NodeID)
            var = Variant.new
            unode = node.id
            wrap do
                LibOpen62541.ua_client_read_attribute_impl(
                    pointerof(@client), 
                    pointerof(unode),
                    LibOpen62541::UaAttributeId::UA_ATTRIBUTEID_VALUE,
                    var,
                    LibOpen62541.ua_types + LibOpen62541::UA_TYPES_VARIANT
                )
            end
            var
        end
    end
end