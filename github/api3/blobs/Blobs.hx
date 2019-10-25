package github.api3.blobs;

import json2object.JsonParser;
import json2object.JsonWriter;
import promhx.Deferred;
import promhx.Promise;

@:access(github.api3.Github)
class Blobs {
    private static inline var API_ROOT:String = Github.API_ROOT + "/repos";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function create(owner:String, repo:String, blob:Blob):Promise<APIResult<Blob>> {
        var d = new Deferred<APIResult<Blob>>();
        var writer = new JsonWriter<Blob>();
        writer.ignoreNullOptionals = true;
        var jsonBlob = writer.write(blob);
        _github.post('${API_ROOT}/${owner}/${repo}/git/blobs', jsonBlob).then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new JsonParser<Blob>();
                var responseBlob:Blob = parser.fromJson(r.data);
                responseBlob.content = blob.content;
                responseBlob.encoding = blob.encoding;
                d.resolve(APIResult.success(responseBlob));
            }
        });
        
        return d.promise();
    }
}