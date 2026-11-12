#define data
name = "The Charm That Loads Boll 2"
desc = "This Charm Loads Boll 2 Levels."

#define start

global.parsejade = code_compile('
lemongrab.thumbx=0
lemongrab.thumby=0
lemongrab.thumbregion=0

show_message(argument[0]);

var loaded,leveldata,level_properties;
loaded = buffer_create(argument[0]);
buffer_inflate(loaded);
leveldata = json_parse(buffer_read_string(loaded));

lemongrab.thumbx=0
lemongrab.thumby=0
lemongrab.thumbregion=0

if json_array_get_number(leveldata, "spawnpoints", 2) < 8 {
    lemongrab.spawnx=json_array_get_number(leveldata, "spawnpoints",0)/16;
    lemongrab.spawny=json_array_get_number(leveldata, "spawnpoints",1)/16;
    lemongrab.spawnr=json_array_get_number(leveldata, "spawnpoints",2);
}
if json_array_get_number(leveldata, "spawnpoints", 5) < 8 {
    lemongrab.tspawnx=json_array_get_number(leveldata, "spawnpoints",3)/16;
    lemongrab.tspawny=json_array_get_number(leveldata, "spawnpoints",4)/16;
    lemongrab.tspawnr=json_array_get_number(leveldata, "spawnpoints",5);
}

lemongrab.levelname=string(json_dotget_string(level_data, "level_properties.name"));
lemongrab.leveldesc=string(json_dotget_string(level_data, "level_properties.desc"));
lemongrab.time=12001


buffer_destroy(loaded);
')

var codestr;
codestr = '
var num,i,name;

alarm[2]=15

global.focus=(external_call(global.dll_foc)==global.winhandle)

//drag and drop detection
if (room==lemon || room==speciale) {
    num=external_call(global.dll_dragnum,global.winhandle)
    if (num) {
        for (i=0;i<num;i+=1) {
            name=external_call(global.dll_dragname,global.winhandle,i)
            if (file_exists(name)) {
                if (room==lemon) {
                    if (filename_ext(name)==".png" || filename_ext(name)==".lemon") {
                        if (!drawregion.flooding) {
                            //load lemon file
                            editload(name)
                        }
                    } else if (filename_ext(name)==".jade") {
                        code_execute(global.parsejade, name);
                    }
                } else if (room==speciale) {
                    if (filename_ext(name)==".txt") {
                        if (!instance_exists(moranboll)) {
                            //load special stage
                            specialeload(name)
                        }
                    }
                }
            }
        }
        external_call(global.dll_dragclear)
    }
}
'

object_event_clear(globalmanager,ev_alarm,2);
object_event_add(globalmanager,ev_alarm,2,codestr);