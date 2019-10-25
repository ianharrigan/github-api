package github.api3.blobs;

class Blob {
    public var content:String;
    public var encoding:String = "utf-8"; // "base64"
    
    @:optional public var url:String = null;
    @:optional public var sha:String = null;
    
    public function new() {
    }
}