///collpos(x, y, force semisolid ground)
//same as collision() but forces a 2x2 mask

var maskr, coll;
maskr=mask_index
mask_index=spr_mask2x2
coll=collision(argument[0],argument[1], argument[2])
mask_index=maskr
return coll
