package github.api3;

import github.api3.blobs.Blob;
import github.api3.references.Reference;
import github.api3.trees.Tree;
import github.api3.trees.TreeItemMode;
import github.api3.trees.TreeItemType;
import haxe.Json;
import promhx.Promise;
import promhx.Deferred;

@:access(github.api3.Github)
class Util {
    private var _github:Github;
    
    public function new(github:Github) {
        _github = github;
    }
    
    public function submitChanges(owner:String, repo:String, ref:String, commitMessage:String, files:Array<File>):Promise<APIResult<Reference>> {
        var d = new Deferred<APIResult<Reference>>();
        
        var currentProgress = 0;
        var maxProgress = files.length + 5;
        _github.log.progress('Querying ref "${owner}/${repo}/${ref}"', currentProgress, maxProgress);
        
        _github.references.get(owner, repo, ref).then(function(r1) {
            if (r1.isErrored) {
                d.resolve(APIResult.errored(r1.errorMessage, r1.httpStatus));
            } else {
                
                currentProgress++;
                _github.log.progress('Querying commit "${r1.data.object.sha}"', currentProgress, maxProgress);
                
                _github.commits.get(owner, repo, r1.data.object.sha).then(function(r2) {
                    if (r2.isErrored) {
                        d.resolve(APIResult.errored(r2.errorMessage, r2.httpStatus));
                    } else {
                        
                        createBlobsFromFiles(owner, repo, files, currentProgress, maxProgress, function(r3) {
                            if (r3.isErrored) {
                                d.resolve(APIResult.errored(r3.errorMessage, r3.httpStatus));
                            } else {
                                
                                currentProgress += files.length + 1;
                                _github.log.progress('Querying tree', currentProgress, maxProgress);
                                
                                _github.trees.get(owner, repo, r2.data.tree.sha).then(function(r4) {
                                    if (r4.isErrored) {
                                        d.resolve(APIResult.errored(r4.errorMessage, r4.httpStatus));
                                    } else {
                                        
                                        var tree = new Tree();
                                        tree.baseTree = r2.data.tree.sha;
                                        for (f in files) {
                                            var item = tree.addItem();
                                            item.sha = f.blob.sha;
                                            item.type = TreeItemType.BLOB;
                                            item.mode = TreeItemMode.BLOB;
                                            item.path = f.filePath;
                                        }
                                        
                                        currentProgress++;
                                        _github.log.progress('Creating new tree for blobs', currentProgress, maxProgress);
                                        
                                        _github.trees.create(owner, repo, tree).then(function(r5) {
                                            if (r5.isErrored) {
                                                d.resolve(APIResult.errored(r5.errorMessage, r5.httpStatus));
                                            } else {

                                                _github.commits.create(owner, repo, {
                                                    message: commitMessage,
                                                    parents: [r2.data.sha],
                                                    tree: r5.data.sha
                                                }).then(function(r6) {
                                                    if (r6.isErrored) {
                                                        d.resolve(APIResult.errored(r6.errorMessage, r6.httpStatus));
                                                    } else {
                                                        
                                                        currentProgress++;
                                                        _github.log.progress('Updating ref with new tree', currentProgress, maxProgress);
                                                        
                                                        _github.references.update(owner, repo, ref, {
                                                            sha: r6.data.sha,
                                                            force: true
                                                        }).then(function(r7) {
                                                            if (r7.isErrored) {
                                                                d.resolve(APIResult.errored(r7.errorMessage, r7.httpStatus));
                                                            } else {
                                                                currentProgress++;
                                                                _github.log.progress('Complete', currentProgress, maxProgress);
                                                                
                                                                d.resolve(APIResult.success(r7.data));
                                                            }
                                                        });
                                                    }
                                                });
                                            }
                                        });
                                    }
                                });
                            }
                        });
                    }
                });
            }
        });
        
        return d.promise();
    }
    
    private function createBlobsFromFiles(owner:String, repo:String, files:Array<File>, currentProgress:Float, maxProgress:Float, fn:APIResult<Array<File>>->Void) {
        var file = null;
        for (f in files) {
            if (f.blob == null) {
                file = f;
                break;
            }
        }
        
        if (file == null) {
            fn(APIResult.success(files));
            return;
        }
        
        currentProgress++;
        _github.log.progress('Creating blob for file "${file.filePath}"', currentProgress, maxProgress);
        
        var blob = new Blob();
        blob.content = file.contents;
        _github.blobs.create(owner, repo, blob).then(function(r) {
            if (r.isErrored) {
                trace(r.errorMessage + ", " + r.httpStatusMessage);
            } else {
                file.blob = r.data;
                createBlobsFromFiles(owner, repo, files, currentProgress, maxProgress, fn);
            }
        });
    }
}