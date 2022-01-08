require "version"
require "./open62541/*"

{% system "mkdir -p build && gcc -c -fPIC -o build/open62541.o src/c/open62541.c && ar rcs build/libopen62541.a build/open62541.o"%}

module Open62541
  VERSION = Version.fetch
end
