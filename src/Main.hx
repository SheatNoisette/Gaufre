package;

import Gaufre;
import FileParser as Fp;

//Remove main in library mode
#if !lib
class Main {
    public static function main() {

        //Create instance
        var gaufre = new Gaufre(32);

        //Get program arguments 
        var ProgramArgs = Sys.args();

        if (ProgramArgs.length == 3) {

        } else {
            Sys.println("- # Gaufre interpreter " + Gaufre.G_VERSION + " -");
            Sys.println("Usage : <File> <Number of memory cells> <Size of the cells>");
        }
        
    }
}

#end