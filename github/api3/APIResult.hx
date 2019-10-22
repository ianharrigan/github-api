package github.api3;

class APIResult<T> {
    public var data:T = null;
    public var httpStatus:Int;
    public var isErrored:Bool = false;
    public var headers:Map<String, String>;
    
    public function new() {
    }
    
    private var _errorMessage:String = null;
    public var errorMessage(get, set):String;
    private function get_errorMessage():String {
        return _errorMessage;
    }
    private function set_errorMessage(value:String):String {
        _errorMessage = value;
        isErrored = (_errorMessage != null);
        return value;
    }

    public var httpStatusMessage(get, null):String;
    private function get_httpStatusMessage():String {
        return HttpStatusMessages.statusCodes.get(httpStatus);
    }
    
    public static function success<T>(data:T, httpStatus:Int = 200):APIResult<T> {
        var r = new APIResult();
        r.data = data;
        r.httpStatus = httpStatus;
        r.isErrored = false;
        return r;
    }
    
    public static function errored<T>(message:String, httpStatus:Int = 500):APIResult<T> {
        var r = new APIResult();
        r.errorMessage = message;
        r.httpStatus = httpStatus;
        r.isErrored = true;
        return r;
    }
}