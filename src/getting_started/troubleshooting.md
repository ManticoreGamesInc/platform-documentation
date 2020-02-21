---
id: troubleshooting
name: Troubleshooting
title: Troubleshooting
---

# Troubleshooting

## Registration / Verification

- Sign up for an account [here](www.coregames.com/register) with the email associated with your Core Alpha invite.
- After your account is successfully created, you will receive a verification email from no-reply@coregames.com titled "Please verify your Core account” so please be sure to check the Promotions tab or spam. Try searching your inbox for "Core" if you cannot find the email. After verifying, you can [login](https://www.coregames.com/login).

If there any issues creating or verifying your account, please email alpha(at)manticoregames.com.

### Installing / Patching

- If the install or patch fails, try uninstalling and reinstalling.
    - Trigger uninstall by deleting (or just move it out of the folder) PlatformVersion.txt from their C:\Users\YourUsernameHere\AppData\Local\Manticore Games\Core\ folder and then launching again for full redownload
    - Alternatively, if you go to the File Location of the "Core Launcher Shortcut", there's the Uninstaller also accessible.
- AntiVirus software, such as Bit Defender and Malwarebytes, sometimes protect the `My Documents` folder.
    - Symptoms: The user can log in and launch the client by clicking a game on the web, but the game doesn't load and drops the user back to the client frontend.
    - Workaround: Disable any "Safe Files" or "Folder Protection" options in your AntiVirus software.
- Windows 7: It's an SSL issue.
    - Symptoms: The launcher can't communicate with the backend. Press <kbd>TAB</kbd> in the Launcher and it will show a log file.
    - Workaround: We're working on it. Otherwise, upgrading to Windows 10 would help.
- Time Travelling. Or just a wrong clock setting.
    - Symptoms: The user is dropped to the client frontend, but none of the above is the issue.
    - Workaround: Check your clock and date and make sure it is correct.
- UE4 Prereqs Install Fail
    - Symptoms: Install fails, your folder has a TMP instead of a TEMP folder.
    - Please report it to the [Discord](https://discord.gg/85k8A7V)!
- TLS Issues: Update their .NET Framework Runtime to 4.8 and try again.
- Requires More Authority
    - Symptoms: The launcher is stuck on "Checking Registry..."
    - Workaround: Start the launcher as the admin user.

### Launcher

- To launch a game, please make sure you have closed the editor beforehand. Users cannot run two instances of Core simultaneously.
- Request Timed Out: Stopped due to network communication failure
    - Check the Certificate (requires technical savviness)
    - Open powershell as ADMIN to c:\windows\system32\
    - Run certutil.exe -generateSSTFromWU roots.sst
    - Double click the c:\windows\system32\roots.sst file to open the updated certificate list
    - Look for USERTrust RSA Certificate Authority double click and press the install button
    - Run Core Launcher and attempt to login
- Foreign Country / Bad Connection: “An existing connection was forcibly closed by the remote host”
    - No re-attempt to resume or restart a failed download in the Launcher, this is a known issue. Please report it to the [Discord](https://discord.gg/85k8A7V)!

### Documentation Site

- If you have the browser extension "uMatrix", you should turn off the entire extension to watch video embeds on this site. Whitelisting the site for that extension does not fix this issue.
