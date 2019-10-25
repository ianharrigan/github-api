package github.api3.references;

import promhx.Promise;
import promhx.Deferred;
import json2object.JsonParser;
import json2object.JsonWriter;

typedef UpdateReferenceParams = {
    public var sha:String;
    @:optional public var force:Null<Bool>;
}

@:access(github.api3.Github)
class References {
    private static inline var API_ROOT:String = Github.API_ROOT + "/repos";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function get(owner:String, repo:String, ref:String):Promise<APIResult<Reference>> {
        var d = new Deferred<APIResult<Reference>>();
        _github.get('${API_ROOT}/${owner}/${repo}/git/ref/${ref}').then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Reference>();
                var ref:Reference = parser.fromJson(r.data);
                d.resolve(APIResult.success(ref));
            }
        });
        
        return d.promise();
    }
    
    public function update(owner:String, repo:String, ref:String, params:UpdateReferenceParams):Promise<APIResult<Reference>> {
        var d = new Deferred<APIResult<Reference>>();
        var writer = new JsonWriter<UpdateReferenceParams>();
        writer.ignoreNullOptionals = true;
        var json = writer.write(params);
        _github.patch('${API_ROOT}/${owner}/${repo}/git/refs/${ref}', json).then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Reference>();
                var ref:Reference = parser.fromJson(r.data);
                d.resolve(APIResult.success(ref));
            }
        });
        
        return d.promise();
    }
}