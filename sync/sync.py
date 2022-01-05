import os
import shutil
from pathlib import Path


def sync_api():
    src_path = os.path.join(
        Path(__file__).parents[2], "LuaAPIDocumentation", "DocumentationOutput", "api"
    )
    src_files = os.listdir(src_path)
    dst_path = os.path.join(Path(__file__).parents[1], "src", "api")
    for file_name in src_files:
        full_file_name = os.path.join(src_path, file_name)
        if os.path.isfile(full_file_name):
            shutil.copy(full_file_name, dst_path)
    print("\x1b[\x1b[32m>>\x1b[0m Syncing API from LuaAPIDocumentation folder\x1b[0m.")
