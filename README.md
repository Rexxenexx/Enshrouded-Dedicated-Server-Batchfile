# Enshrouded-Dedicated-Server-Batchfile

This batch file will start the server, set it to High Priority, (if enabled) backup the savefile in the event of a crash, (if enabled) delete the logfiles, and then restart the server.
Backup and delete logs are disabled by default.
You can also edit the name of the servers exe just in case you are running multiple servers. EX: enshrouded_server.exe, enshrouded_server2.exe, enshrouded_server3.exe, etc.

There is only one file in the zip.
- Run Enshrouded Server.bat


Features
		

Server status in the titlebar
Restart if server crashes
How many restarts since the server first started
Back up the current savegame file after a crash (optional)
Delete all logs (optional)

				
Installation
		

1) Extract the file to your Enshrouded Server directory. Ex: "D:\EnshroudedServer"
2) Edit the <b>Variables</b> section to match your server.
Optional: 3) Enable the delete logfiles feature by setting DeleteLogs to 1. This is so your server doesn't get packed with unnecessary logs
Optional: 4) Enable the backup feature by setting BackupFiles to 1. Edit the paths to where you want your backups.
Optional: 5) By default the server console will start minimized to not pop up into the forground in case of a crash. Set StartMin to 0 if you like the console to pop up.


That's it. Run <b>Run Enshrouded Server.bat</b> to start the server.
Enjoy!
