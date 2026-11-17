var dir;
if !(global.lemontest) || (global.lemonfilename == "") {
    dir = global.lskins[global.levelskin+1,0]
    if (dir == "") {
        dir = global.lbase
    }
    dir = globalmanager.moddir + dir
} else {
    dir = filename_path(global.lemonfilename);
}

dir += "Level Pack Scripts\"

cleanupScripts();

var _file;
_file = file_find_first(dir+"*.gml", 0)

while(_file != "") {
    //find #defines
    var i,_code,_str,_cur,_list,_filepath, _name;
    _name = string_copy(_file,0,string_length(_file)-4);
    _filepath = dir+_file
    if !file_exists(_filepath) {
        continue;
    }

    _code = file_text_open_read(_filepath);
    if (_code == -1) continue;

    _list = ds_list_create();

    _cur = "";
    _str = "";
    while (!file_text_eof(_code)) {
        _cur = file_text_read_string(_code);

        if string_starts_with(_cur, "#define") {
            _cur = string_delete(_cur, 1, 8)
            ds_list_add(_list,_cur)
        }

        file_text_readln(_code);
        if file_text_eof(_code) {
            break;
        }
    }
    file_text_close(_code);

    i=0;
    repeat(ds_list_size(_list)) {
        var _store,_key,_compiled, _codestr;
        _key = ds_list_find_value(_list,i);

        switch(_key) {
            case "start":
                _codestr = loopThrough(_key, _filepath)
                if (_codestr != "") {
                    _compiled = code_compile(_codestr)
                    ds_map_set(global.levelscripts,"create_"+_name,_compiled)
                }
            break;
            case "create":
            case "step":
            case "draw":
            case "trigger":
            case "level_init":
            case "level_end":
                _codestr = loopThrough(_key, _filepath)
                if (_codestr != "") {
                    _compiled = code_compile(_codestr)
                    ds_map_set(global.levelscripts,_key+"_"+_name,_compiled)
                }
            break;
            default : show_message("Invalid define ("+_key+") in "+_file+"!") break;
        }
        i+=1;
    }

    _file = file_find_next();
    ds_list_destroy(_list);
}
_file = file_find_close();
