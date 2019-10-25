package github.api3.trees;

class TreeItem {
    public var path:String;
    public var mode:TreeItemMode;
    public var type:TreeItemType;
    public var sha:String;
    @:optional public var size:Int;
    @:optional public var url:Int;
    
    public function new() {
    }
}    
