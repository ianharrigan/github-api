package github.api3;

@:enum
abstract HttpMethod(String) from String to String {
    var GET = "GET";
    var POST = "POST";
    var PUT = "PUT";
    var DELETE = "DELETE";
    var PATCH = "PATCH";
}