package github.api3.trees;

@:enum
abstract TreeItemType(String) from String to String {
    var BLOB = "blob";
    var TREE = "tree";
    var COMMIT = "commit";
}