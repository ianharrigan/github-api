package github.api3.trees;

class Tree {
    @:optional public var sha:String;
    @:optional public var url:String;
    @:optional @:alias("base_tree") public var baseTree:String;
    @:optional public var trucated:Bool;
    @:optional public var tree:Array<TreeItem> = null;
    
    public function new() {
    }
    
    public function addItem():TreeItem {
        if (tree == null) {
            tree = [];
        }
        
        var item = new TreeItem();
        tree.push(item);
        return item;
    }
}