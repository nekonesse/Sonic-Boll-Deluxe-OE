///script_load(file) (returns script index)
//script system for use in charms (load)
var fn,f,str,thiscode,i;

for (f=open_text(fn);!file_text_eof(f);read_text(f,2)) {
    str+=read_text(f,0)
} close_text(f)

thiscode = code_compile(str);
i=instance_create(0,0,cleanuphelper)
i.event = thiscode;

return thiscode;
