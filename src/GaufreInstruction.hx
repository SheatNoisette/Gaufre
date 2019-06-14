package;

//Gaufre opcodes
enum GOpcodes {
    OP_EXIT;
    OP_INC (times:Int);
    OP_DEC (times:Int);
    OP_MEM_LEFT (times:Int);
    OP_MEM_RIGHT (times:Int);
    OP_GOTO (line:Int);
    //Var1 == Var2 ? goto line
    OP_GOTOEQ (var1:Int, var2:Int, line:Int);
    OP_INPUT;
    OP_OUTPUT;
    //Default opcode
    OP_NONE;
}