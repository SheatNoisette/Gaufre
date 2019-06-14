package;

//Simple string iterator for 'for' loops
class StringIterator {

    var input:String;
    var step:Int;
    var index:Int;
    var end:Int;

    public inline function new (input:String, ?step:Int = 1) {
        this.input = input;
        this.step = step;
        this.index = 0;
        this.end = input.length;
    }

    public inline function hasNext() {
        return index < end;
    }

    public inline function next() {
        return input.charAt((index += step) - step);
    }
}