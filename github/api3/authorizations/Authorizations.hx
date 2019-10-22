package github.api3.authorizations;

import json2object.JsonParser;
import json2object.JsonWriter;
import promhx.Promise;

typedef CreateAuthorizationParams = {
                                            var scopes:Array<Scope>;
                                            var note:String;
    @:alias("note_url") @:optional          var noteUrl:String;
    @:alias("client_id") @:optional         var clientId:String;
    @:alias("client_secret") @:optional     var clientSecret:String;
    @:optional                              var fingerprint:String;
}

typedef GetOrCreateAuthorizationParams = {
                                            var scopes:Array<Scope>;
                                            var note:String;
    @:alias("note_url") @:optional          var noteUrl:String;
    @:alias("client_secret") @:optional     var clientSecret:String;
    @:optional                              var fingerprint:String;
}

typedef UpdateAuthorizationParams = {
    @:optional                              var scopes:Array<Scope>;
    @:alias("add_scopes") @:optional        var addScopes:Array<Scope>;
    @:alias("remove_scopes") @:optional     var removeScopes:Array<Scope>;
    @:optional                              var note:String;
    @:alias("note_url") @:optional          var noteUrl:String;
    @:optional                              var fingerprint:String;
}

@:access(github.api3.Github)
class Authorizations {
    private static inline var API_ROOT:String = Github.API_ROOT + "/authorizations";
    
    private var _github:Github;
    public function new(github:Github) {
        _github = github;
    }
    
    public function list():Promise<APIResult<Array<Authorization>>> {
        return _github.api('${API_ROOT}', HttpMethod.GET, new JsonParser<Array<Authorization>>());
    }
    
    public function get(authorizationId:Int):Promise<APIResult<Authorization>> {
        return _github.api('${API_ROOT}/${authorizationId}', HttpMethod.GET, new JsonParser<Authorization>());
    }
    
    public function create(params:CreateAuthorizationParams):Promise<APIResult<Authorization>> {
        return _github.api('${API_ROOT}', HttpMethod.POST, new JsonParser<Authorization>(), params, new JsonWriter<CreateAuthorizationParams>());
    }
    
    public function getOrCreate(clientId:String, params:GetOrCreateAuthorizationParams):Promise<APIResult<Authorization>> {
        return _github.api('${API_ROOT}/clients/${clientId}', HttpMethod.PUT, new JsonParser<Authorization>(), params, new JsonWriter<GetOrCreateAuthorizationParams>());
    }
    
    public function update(authorizationId:Int, params:UpdateAuthorizationParams):Promise<APIResult<Authorization>> {
        return _github.api('${API_ROOT}/${authorizationId}', HttpMethod.PATCH, new JsonParser<Authorization>(), params, new JsonWriter<UpdateAuthorizationParams>());
    }
}