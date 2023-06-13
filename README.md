[img]https://i.imgur.com/Vv00gp5.png[/img]


[url=http://fondationscp.wikidot.com/incident-096-1-a]Page referring to the object[/url]

[h2]Feature[/h2]
SCRAMBLEs are NVG goggles that (in theory) censor the face of the SCP-096 object.
A black 3D element will appear in place of SCP-096's face.
[img]https://i.imgur.com/oiwpzER.gif[/img]

The SCRAMBLE adapts to the entity's model,
Here is the current list of models and their links that are managed by the entity
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

[h2]Will we be detected by SCP-096 when we wear the goggles?[/h2]

Well [i]yes[i], and [i]no[/i],
Let me explain,
On [url= https://steamcommunity.com/sharedfiles/filedetails/?id=2641523360]Guth's SWEP[/url], wearing the goggles won't trigger SCP-096's rage, but there's a convar you can modify (on the server side only) to give each detection (each server tick) by SCP-096 a chance to trigger SCP-096's rage.
It is set to 0 as default, you can modify it by typing [quote]Scramble_Percent[/quote] and the desired value, between 0 and 100, into the console.

Concerning for the others swep,
For developers, 
You just need to set a condition checking whether the player is wearing the SCRAMBLE and whether it's activated, for example :
[quote]
function IsSCP096Triggered(ply)
    if (ply:GetNWInt("nvg", 0) == 7 and ply:GetNWBool("nvg_on", false)) then
        return true 
    end
    return false
end
[/quote]

If your script have an hook that check if the entity is trigered, tell me, and i will add to the addon.

You can also use the method [quote]scramble.IsDetectedBySCP096()[/quote] which, depending on the value you've set on the convar [quote]Scramble_Percent[/quote] (default 0), can add a random effect depend on the percent indicate, if you don't want players to be totally immune to SCP-096.


[h2]Where is my model ?[/h2]

Well uh,
If you want me to add your model, ask me in the comments to add it with the link to your model, and I'll do it pretty quickly.
But I'm thinking of adding a configuration file soon.


[h2]Credits[/h2]
[list]
[*] Main inspiration for the SCP-096 [url=https://youtu.be/MEOZkf4imaM]short film[/url].
[*] Sound used to detect SCP-096 by Pixabay, you can get it [url=https://pixabay.com/fr/sound-effects/cpu-working-31717/]here[/url].
[/list]

[b]Don't hesitate to tell me if there are bugs or if you would like i add or modify on it.[/b]

If you have any question, don't hesitate to ask on the [url=https://discord.gg/xdA9edwT]discord [/url].
If you want to support my work, click [url= https://wlo.link/@MrMarrant]here[/url].

[i]I hope you laughed. Thank you for laughing with us.[/i]
[img]https://i.imgur.com/nTRVJZ1.gif[/img]
[spoiler]tags: scp , scprp , scp096 , scp 096, scp-096, shy guy, arctic, nvg, Night Vision, Arctic's [/spoiler]