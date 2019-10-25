package github.api3;

import github.api3.applications.Applications;
import github.api3.authorizations.Authorizations;
import github.api3.blobs.Blobs;
import github.api3.commits.Commits;
import github.api3.logging.Logger;
import github.api3.references.References;
import github.api3.repositories.Repositories;
import github.api3.trees.Trees;
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
    
    private var _commits:Commits = null;
    public var commits(get, null):Commits;
    private function get_commits():Commits {
        if (_commits == null) {
            _commits = new Commits(this);
        }
        return _commits;
    }
    
    private var _references:References = null;
    public var references(get, null):References;
    private function get_references():References {
        if (_references == null) {
            _references = new References(this);
        }
        return _references;
    }
    
    private var _blobs:Blobs = null;
    public var blobs(get, null):Blobs;
    private function get_blobs():Blobs {
        if (_blobs == null) {
            _blobs = new Blobs(this);
        }
        return _blobs;
    }
    
    private var _trees:Trees = null;
    public var trees(get, null):Trees;
    private function get_trees():Trees {
        if (_trees == null) {
            _trees = new Trees(this);
        }
        return _trees;
    }
    
    private var _credentials:Credentials = null;
    public var credentials(get, set):Credentials;
    private function get_credentials():Credentials {
        if (_credentials == null) {
            _credentials = new Credentials();
        }
        return _credentials;
    }
    private function set_credentials(value:Credentials):Credentials {
        _credentials = value;
        return value;
    }

    private var _log:Logger = null;
    public var log(get, set):Logger;
    private function get_log():Logger {
        if (_log == null) {
            _log = new Logger();
        }
        return _log;
    }
    private function set_log(value:Logger):Logger {
        _log = value;
        return value;
    }
    
    private var _util:Util = null;
    public var util(get, null):Util;
    private function get_util():Util {
        if (_util == null) {
            _util = new Util(this);
        }
        return _util;
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