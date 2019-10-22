package github.api3.repositories;

import json2object.JsonParser;
import promhx.Promise;

@:access(github.api3.Github)
class Repositories {
    private static inline var API_ROOT:String = Github.API_ROOT + "/repositories";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function list():Promise<APIResult<Array<Repository>>> {
        return _github.api('${API_ROOT}', HttpMethod.GET, new JsonParser<Array<Repository>>());
    }
    
}