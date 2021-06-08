import requests
import subprocess
import sys
from pathlib import Path

outfilePath = "src/assets/api/CoreLuaAPI.json"
requirements = str(Path(__file__).parent.parent) + "/requirements.txt"


def update_dump(environment="Test"):
    baseUrl = f"https://manticore{environment.lower()}.blob.core.windows.net"

    versionEndpoint = f"{baseUrl}/builds/{environment}-latest_client_build.txt"
    latestVersion = requests.get(versionEndpoint)
    dumpEndpoint = f"{baseUrl}/builds/api_export/api-{latestVersion.text}.json"
    r = requests.get(dumpEndpoint.replace("\r\n", ""))
    open(outfilePath, "wb").write(r.content)
    print(f"Updated JSON Dump to version {latestVersion.text}")


def update_environment():
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", requirements, "--upgrade"])
    subprocess.check_call(['npm', "install"])
