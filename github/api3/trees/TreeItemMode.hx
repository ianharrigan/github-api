package github.api3.trees;

@:enum
abstract TreeItemMode(String) from String to String {
    var BLOB = "100644";
    var EXECUTABLE = "100755";
    var SUB_DIRECTORY = "040000";
    var SUB_TREE = "040000";
    var SUB_MODULE = "160000";
    var SUB_COMMIT = "160000";
    var BLOB_SYMLINK = "120000";
}