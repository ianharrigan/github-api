package github.api3.users;

@:access(github.api3.Github)
class Users {
    private static inline var API_ROOT:String = Github.API_ROOT + "/users";

    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
}