package github.api3;

import github.api3.applications.Applications;
import github.api3.authorizations.Authorizations;
import github.api3.repositories.Repositories;
import github.api3.users.Users;
import promhx.Deferred;
import promhx.Promise;

class Github {
    private static inline var API_ROOT:String = "https://api.github.com";
    
    private var _http:HttpClient;
    
    public function new() {
        _http = new HttpClient();
    }
    
    private var _applications:Applications = null;
    public var applications(get, null):Applications;
    private function get_applications():Applications {
        if (_applications == null) {
            _applications = new Applications(this);
        }
        return _applications;
    }
    
    private var _authorizations:Authorizations = null;
    public var authorizations(get, null):Authorizations;
    private function get_authorizations():Authorizations {
        if (_authorizations == null) {
            _authorizations = new Authorizations(this);
        }
        return _authorizations;
    }

    private var _users:Users = null;
    public var users(get, null):Users;
    private function get_users():Users {
        if (_users == null) {
            _users = new Users(this);
        }
        return _users;
    }
    
    private var _repositories:Repositories = null;
    public var repositories(get, null):Repositories;
    private function get_repositories():Repositories {
        if (_repositories == null) {
            _repositories = new Repositories(this);
        }
        return _repositories;
    }
    
    private var _credentials:Credentials = null;
    public var credentials(get, set):Credentials;
    public function get_credentials():Credentials {
        if (_credentials == null) {
            _credentials = new Credentials();
        }
        return _credentials;
    }
    public function set_credentials(value:Credentials):Credentials {
        _credentials = value;
        return value;
    }
    
    private function get(url:String):Promise<APIResult<String>> {
        return _http.get(url, _credentials);
    }

    private function post(url:String, data:String = null):Promise<APIResult<String>> {
        return _http.post(url, _credentials, data);
    }    
 
    private function delete(url:String):Promise<APIResult<String>> {
        return _http.delete(url, _credentials);
    }
    
    private function put(url:String, data:String = null):Promise<APIResult<String>> {
        return _http.put(url, _credentials, data);
    }
    
    private function patch(url:String, data:String = null):Promise<APIResult<String>> {
        return _http.patch(url, _credentials, data);
    }
    
    // Error: json2object: Type parameters are not parsable: T
    private function api<T>(url:String, method:HttpMethod, parser:Dynamic = null, params:Any = null, writer:Dynamic = null):Promise<APIResult<T>> {
        var d = new Deferred<APIResult<T>>();

        var json:String = null;
        if (params != null && writer != null) {
            writer.ignoreNullOptionals = true;
            json = writer.write(params);
        }
        
        _http.rest(url, method, _credentials, json).then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                // Error: json2object: Type parameters are not parsable: T
                // var parser = new json2object.JsonParser<T>();
                if (parser != null) {
                    d.resolve(APIResult.success(parser.fromJson(r.data)));  
                }
            }
        });
        
        return d.promise();
    }
}