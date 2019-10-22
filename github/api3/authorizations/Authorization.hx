package github.api3.authorizations;

import github.api3.applications.Application;
import github.api3.users.User;

class Authorization {
                                        public var id:Int;
                                        public var url:String;
                                        public var app:Application;
                                        public var token:String;
    @:alias("hashed_token")             public var hashedToken:String;
    @:alias("token_last_eight")         public var tokenLastEight:String;
    @:alias("note")                     public var note:String;
    @:alias("note_url")                 public var noteUrl:String;
    @:alias("created_at")               public var createdAt:String;
    @:alias("updated_at")               public var updatedAt:String;
                                        public var scopes:Array<Scope>;
                                        public var fingerprint:String;
    @:optional                          public var user:User;
    
    public function new() {
    }
}