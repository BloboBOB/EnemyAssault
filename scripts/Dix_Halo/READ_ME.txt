Place these three lines on your C130J
first line is the Interior Lighting, Second and the Third lines are needed for the Halo option.

nul = [this] execVM "scripts\Dix_Halo\IntLightSwitch.sqf";
nul = [this] execVM "scripts\Dix_Halo\ready.sqf";
this addaction ["<t color='#b4ffeb'>HALO","halo.sqf",[],2,false,true,"","_target getVariable 'Jump_time'"];

I would like to thank Kylania, Ghost, all the people on Ghostland and anyone else who helped test scripts to get this functional.
I would alos like to thank Flannel for his Rato script https://www.dropbox.com/s/hqkopdkrdvwbp39/C-130J%20RATO.rar ,
the basis for most of the script I used. Also Ghost for his  Halo script and cobra4v320 for the ventral backpack oprtion of the halo.


 
