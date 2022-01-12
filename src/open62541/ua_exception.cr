module Open62541
    def self.get_status_code_string(c)
        {% begin %}
            case c
            {% for const in LibOpen62541.constants %}
                {% if const.stringify.starts_with? "UA_STATUSCODE" %}
                    when {{ LibOpen62541.constant(const) }}
                        {{const.stringify}}
                {% end %}
            {% end %}
            else
                "<unknown code>"
            end
        {% end %}
    end

    class UAException < Exception
        property code

        def initialize(@code : LibOpen62541::UaStatusCode)
            super Open62541.get_status_code_string @code
        end
    end
end