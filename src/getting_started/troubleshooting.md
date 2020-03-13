---
id: troubleshooting
name: Troubleshooting
title: Troubleshooting
---

# Troubleshooting

## Installing / Patching

- AntiVirus software, such as Bit Defender and Malwarebytes, sometimes protect the `My Documents` folder.
    - Symptoms: The user can log in and launch the client by clicking a game on the web, but the game doesn't load and drops the user back to the client frontend.
    - Workaround: Disable any "Safe Files" or "Folder Protection" options in your AntiVirus software.
- Windows 7: It's an SSL issue.
    - Symptoms: The launcher can't communicate with the backend. Press <kbd>TAB</kbd> in the Launcher and it will show a log file.
    - Workaround: We're working on it. Otherwise, upgrading to Windows 10 would help.
- Time Travelling. Or just a wrong clock setting.
    - Symptoms: The user is dropped to the client frontend, but none of the above is the issue.
    - Workaround: Check your clock and date and make sure it is correct.
- TLS Issues: Update their .NET Framework Runtime to 4.8 and try again.
- Requires More Authority
    - Symptoms: The launcher is stuck on "Checking Registry..."
    - Workaround: Start the launcher as the admin user.

## Launcher

- Request Timed Out: Stopped due to network communication failure
    - Check the Certificate (requires technical savviness)
    - Open powershell as ADMIN to c:\windows\system32\
    - Run certutil.exe -generateSSTFromWU roots.sst
    - Double click the c:\windows\system32\roots.sst file to open the updated certificate list
    - Look for USERTrust RSA Certificate Authority double click and press the install button
    - Run Core Launcher and attempt to login
- Foreign Country / Bad Connection: “An existing connection was forcibly closed by the remote host”
    - No re-attempt to resume or restart a failed download in the Launcher, this is a known issue. Please report it to the [Discord](https://discord.gg/core-creators)!
