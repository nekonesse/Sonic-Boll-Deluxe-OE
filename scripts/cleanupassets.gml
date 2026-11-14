///cleanupassets();
//wipes the asset sprites from memory
var size,key,i,asset;
size = ds_map_size(global.assetmap);
key = ds_map_find_first(global.assetmap);
i=0;
repeat(size) {
    asset = ds_map_find_value(global.assetmap, key);
    if (background_exists(asset)) && (asset != 0) {
        background_delete(asset);
    }
    key = ds_map_find_next(global.assetmap, key);
    i+=1;
}
ds_map_clear(global.assetmap);
