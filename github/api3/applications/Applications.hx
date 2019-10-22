package github.api3.applications;

import github.api3.authorizations.Authorization;
import github.api3.grants.Grants;
import json2object.JsonParser;
import promhx.Deferred;
import promhx.Promise;

@:access(github.api3.Github)
class Applications {
    private static inline var API_ROOT:String = Github.API_ROOT + "/applications";
    
    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }

    private var _grants:Grants = null;
    public var grants(get, null):Grants;
    private function get_grants():Grants {
        if (_grants == null) {
            _grants = new Grants(_github);
        }
        return _grants;
    }
    
    public function checkAccessToken(accessToken:String, clientId:String, clientSecret:String):Promise<APIResult<Authorization>> {
        var d = new Deferred<APIResult<Authorization>>();
     
        _github.credentials.cache();
        _github.credentials.basicAuth = Credentials.encodeBasicAuth(clientId, clientSecret);
        _github.get('${API_ROOT}/${clientId}/tokens/${accessToken}').then(function(r) {
            _github.credentials.restore();
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Authorization>();
                var authorization:Authorization = parser.fromJson(r.data);
                d.resolve(APIResult.success(authorization));
            }
        });
        
        return d.promise();
    }
}