package github.api3.logging;

class TraceLogger extends Logger {
    public override function progress(message:String, current:Float, max:Float):Void {
        trace(current + " of " + max + ": " + message);
    }
}