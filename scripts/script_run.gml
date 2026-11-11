///script_run(index, arg1, arg2..)
//script system for use in charms (run)

//Dear. God.
switch(argument_count) {
    case 0:
    break;
    case 1:
    code_execute(argument0);
    break;
    case 2:
    code_execute(argument0,argument1);
    break;
    case 3:
    code_execute(argument0,argument1,argument2);
    break;
    case 4:
    code_execute(argument0,argument1,argument2,argument3);
    break;
    case 5:
    code_execute(argument0,argument1,argument2,argument3,argument4);
    break;
    case 6:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5);
    break;
    case 7:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6);
    break;
    case 8:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7);
    break;
    case 9:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8);
    break;
    case 10:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9);
    break;
    case 11:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10);
    break;
    case 12:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11);
    break;
    case 13:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12);
    break;
    case 14:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12,argument13);
    break;
    case 15:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12,argument14,argument14);
    break;
    case 16:
    code_execute(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7,argument8,argument9,argument10,argument11,argument12,argument13,argument14,argument15);
    break;
}
