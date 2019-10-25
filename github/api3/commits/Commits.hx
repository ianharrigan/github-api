package github.api3.commits;

import json2object.JsonParser;
import json2object.JsonWriter;
import promhx.Deferred;
import promhx.Promise;

typedef CreateCommitParams = {
    var message:String;
    var parents:Array<String>;
    var tree:String;
}

@:access(github.api3.Github)
class Commits {
    private static inline var API_ROOT:String = Github.API_ROOT + "/repos";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function get(owner:String, repo:String, sha:String):Promise<APIResult<Commit>> {
        var d = new Deferred<APIResult<Commit>>();
        _github.get('${API_ROOT}/${owner}/${repo}/git/commits/${sha}').then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Commit>();
                var ref:Commit = parser.fromJson(r.data);
                d.resolve(APIResult.success(ref));
            }
        });
        
        return d.promise();
    }
    
    public function create(owner:String, repo:String, params:CreateCommitParams):Promise<APIResult<CommitItem>> {
        var d = new Deferred<APIResult<CommitItem>>();
        var writer = new JsonWriter<CreateCommitParams>();
        writer.ignoreNullOptionals = true;
        var json = writer.write(params);
        _github.post('${API_ROOT}/${owner}/${repo}/git/commits', json).then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<CommitItem>();
                var item:CommitItem = parser.fromJson(r.data);
                d.resolve(APIResult.success(item));
            }
        });
        
        return d.promise();
    }
}