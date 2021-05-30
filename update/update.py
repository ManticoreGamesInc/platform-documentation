import requests

outfilePath = "src/assets/api/CoreLuaAPI.json"


def update_dump(environment="Test"):
    baseUrl = f"https://manticore{environment.lower()}.blob.core.windows.net"

    versionEndpoint = f"{baseUrl}/builds/{environment}-latest_client_build.txt"
    latestVersion = requests.get(versionEndpoint)
    dumpEndpoint = f"{baseUrl}/builds/api_export/api-{latestVersion.text}.json"
    r = requests.get(dumpEndpoint.replace("\r\n", ""))
    open(outfilePath, "wb").write(r.content)
    print(f"Updated JSON Dump to version {latestVersion.text}")
