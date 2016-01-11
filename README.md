## How to Wololo Windows Defender ##

Full post: http://www.codingfree.com/how-to-wololo-windows-defender/

It has some basic functions:

    -scan: Scans the current directory in "hardcore mode". What do I mean by hardcore mode? It sets the CPU usage to 80%, does a full scan and when it finishes the scan, it restore the optimized settings. It is useful if you want to make a full scan and you want to do it as faster as possible.
    -update: It updates the signatures. It is only a wrapper, but helps to shorten the strange name for that function.
    -clean: It removes all the exceptions. All of them, with no exception (ba dum tss).
    -addRecursive: Adds all the .exe binaries to the exceptions list recursively. Well, I wanted to play with some crackmes and I was lazy to add all of them one by one, so I did this to bulk add them.
    -optimize: This is the most interesting option, I'll try to summarize it.

It enables (because it disables the "disabled" option...) the catchup scans. It means that if you have any scheduled scan and the computer missed it, it will do it later. If you have an scan scheduled it was for a good reason.

CheckForSignaturesBeforeRunningScan  and SignatureDisableUpdateOnStartupWithoutEngine . They force to update the signatures when the engine is started but also before starting any scan. I think that it is not useful to scan something with outdated signatures, so why not to make sure they are up-to-date? Just in case.

RealTimeScanDirection Incoming: it only will scan incoming files. Because we want to save processor and we don't care if we infect the world. Just troll the Internet.

SignatureScheduleDay 0. Come on, lets update them daily.

ThreatIDDefaultAction_Action: If it finds anything suspicious, it sends the file to quarantine. It won't be funny if you set to Remove (3) the file (maybe I'm wrong).

ScanAvgCPULoadFactor: Do you remember the hardcore mode? Well, If we don't need to scan everything and we want to do anything else meanwhile, why not to set the usage at 20%? It will take more time to finish but if you are in a hurry, just use the hardcore mode.

ScanOnlyIfIdleEnable: Well, Windows Defender will use less CPU, but also we would like to do the scan only if we are compiling something or playing a game. Both things = kaboom. With this option it will start the scan only if the processor is having some PTO. No holidays for you, Windows Defender!

And that's all, so far. I could add more options and more functions, but this works for me. Anyways, you can change any action at any time, so If you are wearing a white hat and you are concerned about the security of the world don't blame me.

Fork me, please!
