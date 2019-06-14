package;

import StringIterator;

//Useful functions not provided by the Haxe standard library
class Utils {

    // Create a array of length 'size'
    public static function CreateEmptyIntArray(size:Int, fillerValue:Int):Array<Int> {

        var customArray:Array<Int> = [];
        var cursor:Int = 0;

        while (cursor < size){
            customArray.push(fillerValue);
            cursor++;
        }

        return customArray;
    }

    // Haxe Standard library doesn't have int based aboslute value function
    public static function IntAbs (value:Int):Int
    {
        return value < 0 ? -value : value;
    }

    // Count the number of char present in a string - Not provided by Haxe Standard Lib
    public static function CountChar(input:String, checkChar:String):Int {

        var counter = 0;
        
        for (char in new StringIterator(input))
        {
            if (char == checkChar)
                counter++;
        }

        return counter;
    }
}