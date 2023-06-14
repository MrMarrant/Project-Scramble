[img]https://i.imgur.com/0QDWRb4.png[/img]

[url=http://fondationscp.wikidot.com/incident-096-1-a]Page referring to the object[/url]

[h2]Feature[/h2]
SCRAMBLEs are NVG goggles that (in theory) censor the face of the SCP-096 object.
A black 3D element will appear in place of SCP-096's face.
[img]https://i.imgur.com/oiwpzER.gif[/img]

The SCRAMBLE adapts to the entity's model,
Here is the current list of models and their workshop links that are managed by the entity by default :
[table]
[tr]
[th]Path Model[/th]
[th]Link WorkShop[/th]
[/tr]
[tr]
[td]models/scp096anim/player/scp096pm_raf.mdl[/td]
[th][url=https://steamcommunity.com/sharedfiles/filedetails/?id=958509894]SCP-096 Animated Player Model[/url][/th]
[/tr]
[tr]
[td]models/shaklin/scp/096/scp_096.mdl[/td]
[td][url=https://steamcommunity.com/sharedfiles/filedetails/?id=367531149]SCP 096 - Nextbot[/url][/td]
[/tr]
[tr]
[td]models/player/scp096.mdl[/td]
[td][url=https://steamcommunity.com/sharedfiles/filedetails/?id=426985804]SCP 096 Player Model[/url][/td]
[/tr]
[/table]

[h2]Config[/h2]

[h3]Addon Require[h3]
You must install the necessary addon [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2389553185][VManip] Arctic's Night Vision[/url] for it to work, the entity will appear in the same list as the other NVGs.
You can set up a convar for chance detection by SCP-096 aswell, explanation just below.

[h3]Convar[h3]
There's a convar called Scramble_Percent, which defaults to 0, and can only be modified server-side in your server console.
It can be defined with a value ranging from 0 to 100.
Note that this currently only works on the [url= https://steamcommunity.com/sharedfiles/filedetails/?id=2641523360]Guth's SWEP[/url].
It allows you to manage the percentage of chance that you'll activate the SCP-096 rage effect even if you're looking at it through your glasses.
0 being the value where SCP-096 will never be triggered, and 100 where it will be triggered every time.

[h3]Add Models Detected[h3]

There's a folder containing a file that defines the templates to manage on which the censorship effect will be applied, by default there's the list described above, but you can add the template you like if you wish, the path of the file is as follows:
[quote]YourDirectoryRoot\Steam\steamapps\common\GarrysMod\garrysmod\data\data_scramble/scramble_config.json[/quote]

For add a model, scrupulously respect the models already indicated: 
First line: the model path, indicate the path of the model, you can get it by doing right click on the model in the props menu.
Value "x", "y", "z", in certain model cases, the position of the censoring effect needs to be adjusted slightly, set them to 0 for all three and adjust after if it need some modification.
Value "head" : This is the identifier used to retrieve the bone head of the model, be warned, somes models don't have head, to retrieve the name, I recommend you use the addon [url= https://steamcommunity.com/sharedfiles/filedetails/?id=104575630]Ragdoll Mover[/url], and copy/paste the name displayed by the tool when you aim at the model's head.
Next, reload your game/server, and this will be ok.


[h2]Will we be detected by SCP-096 when we wear the goggles?[/h2]

Currently, only the [url= https://steamcommunity.com/sharedfiles/filedetails/?id=2641523360]Guth's SWEP[/url] does not trigger the SCP-096 rage effect.

[b]Why ?[/b]

Well, most of the SWEPs that activate the SCP-096 rage effect have no way of being managed by a third-party script, so the only solution would be to modify the SWEP concerned directly.
In the case of guth's SWEP, it offers a method for managing SCP-096's rage state outside of his script.

Concerning for the others SWEP,
[b]For developers :[/b]
You just need to set a condition checking whether the player is wearing the SCRAMBLE and whether it's activated, for example :
[quote]
function IsSCP096Triggered(ply)
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        return true 
    end
    return false
end
[/quote]
I recommend to do it Server Side only for security reasons.

[quote]ply:GetNWInt("nvg", 0)[/quote] Is the var used by arctic to know what type of glasses you are currently wearing, 7 correspond to the type of the SCRAMBLE.
[quote]ply:GetNWBool("nvg_on", false)[/quote] Is the var used by arctic to know if the NVG are enabled or not.

If your script have an hook that check if the entity is trigered, tell me, and i will add to the addon.

You can also use the method [quote]scramble.IsDetectedBySCP096()[/quote] which, depending on the value you've set on the convar [quote]Scramble_Percent[/quote] (default 0), can add a random effect depend on the percent indicate, if you don't want players to be totally immune to SCP-096.


[h2]Where is my model ?[/h2]

Well uh,
If you want me to add your model because you don't know how to do it with the config file even with the explanation, ask me in the comments to add it with the link to your model, and I'll do it pretty quickly.


[h2]Credits[/h2]
[list]
[*] Main inspiration for the SCP-096 [url=https://youtu.be/MEOZkf4imaM]short film[/url].
[*] Sound used to detect SCP-096 by Pixabay, you can get it [url=https://pixabay.com/fr/sound-effects/cpu-working-31717/]here[/url].
[*] Arctic for the NVG addon ofc
[*] Trybochist for the map used on the presentation video, link [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2907427026]here[/url].
[/list]

[b]Don't hesitate to tell me if there are bugs or if you would like i add or modify on it.[/b]

If you have any question, don't hesitate to ask on the [url=https://discord.gg/tuMNx3PkkP]discord [/url].
If you want to support my work, click [url= https://wlo.link/@MrMarrant]here[/url].

[i]I hope you laughed. Thank you for laughing with us.[/i]
[img]https://i.imgur.com/nTRVJZ1.gif[/img]
[spoiler]tags: scp , scprp , scp096 , scp 096, scp-096, shy guy, arctic, nvg, Night Vision, Arctic's [/spoiler]