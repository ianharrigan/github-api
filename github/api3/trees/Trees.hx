package github.api3.trees;

import json2object.JsonParser;
import json2object.JsonWriter;
import promhx.Deferred;
import promhx.Promise;

@:access(github.api3.Github)
class Trees {
    private static inline var API_ROOT:String = Github.API_ROOT + "/repos";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function get(owner:String, repo:String, treeSha:String):Promise<APIResult<Tree>> {
        var d = new Deferred<APIResult<Tree>>();
        _github.get('${API_ROOT}/${owner}/${repo}/git/trees/${treeSha}').then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Tree>();
                var tree:Tree = parser.fromJson(r.data);
                d.resolve(APIResult.success(tree));
            }
        });
        
        return d.promise();
    }
    
    public function create(owner:String, repo:String, tree:Tree):Promise<APIResult<Tree>> {
        var d = new Deferred<APIResult<Tree>>();
        var writer = new JsonWriter<Tree>();
        writer.ignoreNullOptionals = true;
        var jsonTree = writer.write(tree);
        _github.post('${API_ROOT}/${owner}/${repo}/git/trees', jsonTree).then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Tree>();
                var responseTree:Tree = parser.fromJson(r.data);
                d.resolve(APIResult.success(responseTree));
            }
        });
        
        return d.promise();
    }
}