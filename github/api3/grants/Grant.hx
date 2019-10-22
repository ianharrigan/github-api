package github.api3.grants;
import github.api3.applications.Application;

class Grant {
                                    public var id:Int;
                                    public var url:String;
                                    public var app:Application;
        @:alias("created_at")       public var createdAt:String;
        @:alias("updated_at")       public var updatedAt:String;
                                    public var scopes:Array<Scope>;

        public function new() {
        }
}