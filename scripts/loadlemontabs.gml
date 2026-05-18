var i,l;

with (palbutton) instance_destroy()

with (editmanager) {
    tab=argument[0]
    tabnames[0]="General"
    tabshortcut[0]="C"
    tabnames[1]="Items"
    tabshortcut[1]="X"
    tabnames[2]="Hazards"
    tabshortcut[2]="Z"
    tabnames[3]="Gizmos"
    tabshortcut[3]="V"
    tabnames[4]="Technical"
    tabshortcut[4]="B"
    tabnames[5]="W.I.P"
    tabshortcut[5]="N"
}

//Main (In development)
if (argument[0]=0) {
    l[ 0]=-1           l[ 1]=-1     l[ 2]=door      l[ 3]=-1     l[ 4]=platform      l[ 5]=vine  l[ 6]=treeblock   l[ 7]=mushblock      l[8]=itembox       l[ 9]=monitor         l[10]=crackedblock    l[11]=crate        l[12]=brick              l[13]=mushroom      l[14]=shield    l[15]=-1         l[16]=-1          l[17]=goalblock      l[18]=-1        l[19]=-1
    l[20]=-1           l[21]=-1     l[22]=pipeblock l[23]=-1     l[24]=platdonut     l[25]=fence l[26]=bridgetile  l[27]=bridge         l[28]=hardblock    l[29]=sloper1         l[30]=sloper2b        l[31]=slopel1s     l[32]=castleceiling      l[33]=flower        l[34]=feather   l[35]=-1         l[36]=checkpoint  l[37]=retainer       l[38]=flagpole  l[39]=-1
    l[40]=-1           l[41]=-1     l[42]=warpbox   l[43]=-1     l[44]=cloudtile     l[45]=-1    l[46]=waterblock  l[47]=lavablock      l[48]=sloper2      l[49]=groundblock     l[50]=groundback       l[51]=groundsemi   l[52]=slopel2s           l[53]=starman       l[54]=lifemush  l[55]=-1         l[56]=-1          l[57]=signpost       l[58]=-1        l[59]=-1
}
//Items
if (argument[0]=1) {
    l[ 0]=-1           l[ 1]=-1     l[ 2]=coin      l[ 3]=itemring    l[ 4]=mushroom    l[ 5]=mushmini   l[ 6]=starman     l[ 7]=starshard        l[8]=shell     l[ 9]=token         l[10]=-1       l[11]=-1     l[12]=-1     l[13]=-1      l[14]=-1    l[15]=-1        l[16]=-1    l[17]=-1       l[18]=-1     l[19]=-1
    l[20]=-1           l[21]=-1     l[22]=redcoin   l[23]=redring     l[24]=flower      l[25]=lifemush   l[26]=shield      l[27]=jumprefresh      l[28]=pswitch  l[29]=tokencruncher         l[30]=-1       l[31]=-1     l[32]=-1     l[33]=-1      l[34]=-1    l[35]=-1        l[36]=-1    l[37]=-1       l[38]=-1     l[39]=-1
    l[40]=-1           l[41]=-1     l[42]=keyitem   l[43]=carditem    l[44]=feather     l[45]=mushpoison l[46]=itemlaunch  l[47]=monitor          l[48]=bluecoin       l[49]=cardreader         l[50]=-1       l[51]=-1     l[52]=-1     l[53]=-1      l[54]=-1    l[55]=-1        l[56]=-1    l[57]=-1       l[58]=-1     l[59]=-1
}
//Hazards
if (argument[0]=2) {
    l[ 0]=-1           l[ 1]=goomba        l[ 2]=koopa       l[ 3]=piranha        l[ 4]=fbarblock          l[ 5]=sonicspike    l[ 6]=spikecrusher     l[ 7]=ballcannon         l[8]=ballcannonquad      l[ 9]=singlecheep      l[10]=blooper               l[11]=newtron           l[12]=montymole  l[13]=lakitu         l[14]=bowserboss  l[15]=bombenemy         l[16]=-1  l[17]=delfruit       l[18]=-1     l[19]=-1
    l[20]=-1           l[21]=goombrat      l[22]=hopkoopa    l[23]=firepiranha    l[24]=podoboo            l[25]=spike         l[26]=swinginghammer   l[27]=bulletbill         l[28]=bullseyebill       l[29]=fishbones        l[30]=boo                   l[31]=crabmeat          l[32]=rexbig     l[33]=spiny          l[34]=-1          l[35]=bobomb            l[36]=-1  l[37]=enemydummy             l[38]=-1     l[39]=-1
    l[40]=-1           l[41]=spikenemy     l[42]=drybones    l[43]=hammerbro      l[44]=fireballshooter    l[45]=grinder       l[46]=thwomp           l[47]=cannon             l[48]=redcannon          l[49]=urchin           l[50]=chopper                    l[51]=orbinautgreen     l[52]=pokey         l[53]=beetle         l[54]=-1          l[55]=-1                l[56]=-1  l[57]=-1             l[58]=-1     l[59]=-1
}
//Gizmos (Needs Reorganization)
if (argument[0]=3) {
    l[ 0]=-1           l[ 1]=-1     l[ 2]=onswitch  l[ 3]=onoffscreen l[ 4]=cardreader    l[ 5]=skullblock   l[ 6]=bumper     l[ 7]=cork       l[8]=dashpanel     l[ 9]=beepblockon         l[10]=gearplatform       l[11]=chardoor     l[12]=-1     l[13]=-1      l[14]=-1    l[15]=-1        l[16]=spring    l[17]=pollenflower       l[18]=-1     l[19]=-1
    l[20]=-1           l[21]=-1     l[22]=onblock   l[23]=onspike     l[24]=carditem      l[25]=skullbloff   l[26]=powblock   l[27]=stone      l[28]=conveyorbelt       l[29]=beepblockoff         l[30]=-1       l[31]=-1     l[32]=-1     l[33]=-1      l[34]=-1    l[35]=-1        l[36]=spreng    l[37]=terrainspring       l[38]=-1     l[39]=-1
    l[40]=-1           l[41]=-1     l[42]=offblock  l[43]=offspike    l[44]=frogswitch    l[45]=konblock           l[46]=pswitch         l[47]=crystaltap l[48]=-1       l[49]=-1         l[50]=-1       l[51]=-1     l[52]=-1     l[53]=-1      l[54]=-1    l[55]=-1        l[56]=sprong    l[57]=terrainsprong      l[58]=-1     l[59]=-1
}
//Technical
if (argument[0]=4) {
    l[ 0]=-1           l[ 1]=signalcommunicator     l[ 2]=bopblock  l[ 3]=gate l[ 4]=gobble    l[ 5]=axe   l[ 6]=anchor     l[ 7]=segafadewarp       l[8]=talkbox     l[ 9]=phaser         l[10]=bulletspawner       l[11]=tyler     l[12]=ground     l[13]=-1      l[14]=trigger_spawn    l[15]=-1        l[16]=-1          l[17]=-1       l[18]=-1    l[19]=-1
    l[20]=-1           l[21]=button     l[22]=onoffscreen   l[23]=spawnerblock     l[24]=variableblock      l[25]=lightbulb   l[26]=mark   l[27]=barrier      l[28]=textblock       l[29]=grateblock        l[30]=cheepspawner       l[31]=terraintyler     l[32]=decortyler     l[33]=activate_region      l[34]=-1    l[35]=-1        l[36]=-1    l[37]=-1       l[38]=-1     l[39]=-1
    l[40]=-1           l[41]=detector     l[42]=timerblock  l[43]=signalblock    l[44]=ireader            l[45]=channelmaster           l[46]=code         l[47]=segafadedest l[48]=heaven      l[49]=x1F0         l[50]=spawncancel       l[51]=objectstyler     l[52]=jetstream     l[53]=-1      l[54]=-1    l[55]=-1        l[56]=-1              l[57]=-1       l[58]=-1     l[59]=-1
}
//WIP
if (argument[0]=5) {
    l[ 0]=-1 l[ 1]=-1 l[ 2]=terrainspring     l[ 3]=groundback l[ 4]=wigglerhead     l[ 5]=freemover   l[ 6]=nslopl    l[ 7]=-1 l[ 8]=-1 l[ 9]=-1 l[10]=-1 l[11]=-1 l[12]=-1 l[13]=-1 l[14]=-1 l[15]=-1
    l[16]=-1 l[17]=-1 l[18]=pokey l[19]=-1 l[20]=beetroot   l[21]=greenlui l[22]=pig  l[23]=-1 l[24]=-1 l[25]=-1 l[26]=-1 l[27]=-1 l[28]=-1 l[29]=-1 l[30]=-1 l[31]=-1
    l[32]=-1 l[33]=-1 l[34]=pollenflower    l[35]=-1 l[36]=-1 l[37]=-1   l[38]=-1    l[39]=-1 l[40]=-1 l[41]=-1 l[42]=-1 l[43]=-1 l[44]=-1 l[45]=-1 l[46]=-1 l[47]=-1
}

for (i=0;i<60;i+=1) {
    if (l[i]!=-1) with (instance_create(0,0,palbutton)) {self.i=i obj=editobjfind(l[i])}
}
