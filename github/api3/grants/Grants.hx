package github.api3.grants;

import github.api3.applications.Applications;
import promhx.Deferred;
import promhx.Promise;

@:access(github.api3.Github)
@:access(github.api3.applications.Applications)
class Grants {
    private static inline var API_ROOT:String = Applications.API_ROOT + "/grants";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function list():Promise<APIResult<Array<Grant>>> {
        var d = new Deferred<APIResult<Array<Grant>>>();
        _github.get(API_ROOT).then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new json2object.JsonParser<Array<Grant>>();
                var grants:Array<Grant> = parser.fromJson(r.data);
                d.resolve(APIResult.success(grants));
            }
        });
        
        return d.promise();
    }
    
    public function get(grantId:Int):Promise<APIResult<Grant>> {
        var d = new Deferred<APIResult<Grant>>();
        
        _github.get('${API_ROOT}/${grantId}').then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                var parser = new json2object.JsonParser<Grant>();
                var grant:Grant = parser.fromJson(r.data);
                d.resolve(APIResult.success(grant));
            }
        });
        
        return d.promise();
    }
    
    public function delete(grantId:Int):Promise<APIResult<Bool>> {
        var d = new Deferred<APIResult<Bool>>();
        
        _github.delete('${API_ROOT}/${grantId}').then(function(r) {
            if (r.isErrored) {
                d.resolve(APIResult.errored(r.errorMessage, r.httpStatus));
            } else {
                d.resolve(APIResult.success(true));
            }
        });
        
        return d.promise();
    }
}