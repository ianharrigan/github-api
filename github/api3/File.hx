package github.api3;
import github.api3.blobs.Blob;

class File {
    public var filePath:String;
    public var contents:Dynamic;
    
    public var blob:Blob = null;
    
    public function new(filePath:String = null, contents:Dynamic = null) {
        this.filePath = filePath;
        this.contents = contents;
    }
}