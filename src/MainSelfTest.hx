package;

import FileParser as Fp;
import Gaufre;
import tests.*;

/*
    Here is the auto-tests of the Gaufre interpreter
*/

class MainSelfTest {

    public static function main() {
        var runner = new haxe.unit.TestRunner();
        //-----------------------
        //!TESTS HERE!

        //Test class: FileParser
        runner.add(new FileParserTests());

        //Test class: GaufreTests
        runner.add(new GaufreTests());

        //Test class: OverflowTests
        runner.add(new OverflowTests());
        
        //Test class: FuzzerTests
        runner.add(new FuzzerTests());

        //Run tests
        runner.run();
    }
}