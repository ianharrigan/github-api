package github.api3.logging;

interface ILogger {
    function progress(message:String, current:Float, max:Float):Void;
}