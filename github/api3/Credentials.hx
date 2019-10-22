package github.api3;
import haxe.crypto.Base64;
import haxe.io.Bytes;

class Credentials {
    public function new() {
    }
    
    public static function encodeBasicAuth(username:String, password:String) {
        return Base64.encode(Bytes.ofString('${username}:${password}'));
    }
    
    private var _basicAuth:String = null;
    public var basicAuth(get, set):String;
    private function get_basicAuth():String {
        return _basicAuth;
    }
    private function set_basicAuth(value:String):String {
        _basicAuth = value;
        return value;
    }
    
    private var _oauthToken:String = null;
    public  var oauthToken(get, set):String;
    private function get_oauthToken():String {
        return _oauthToken;
    }
    private function set_oauthToken(value:String):String {
        if (value != null) {
            _basicAuth = null;
        }
        _oauthToken = value;
        return value;
    }
    
    public var hasBasicAuth(get, null):Bool;
    private function get_hasBasicAuth():Bool {
        return (_basicAuth != null && _basicAuth.length > 0);
    }
    
    public var hasOAuthToken(get, null):Bool;
    private function get_hasOAuthToken():Bool {
        return (_oauthToken != null && _oauthToken.length > 0);
    }
    
    private var _cachedBasicAuth:String = null;
    private var _cachedOAuthToken:String = null;
    public function cache(clearDetails:Bool = true) {
        _cachedBasicAuth = _basicAuth;
        _cachedOAuthToken = _oauthToken;
        if (clearDetails == true) {
            clear();
        }
    }
    
    public function clear() {
        _basicAuth = null;
        _oauthToken = null;
    }
    
    public function restore() {
        _basicAuth = _cachedBasicAuth;
        oauthToken = _cachedOAuthToken;
        _cachedBasicAuth = null;
        _cachedOAuthToken = null;
    }
}