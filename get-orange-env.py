import os
import json
import subprocess

def get_conda_envs():
    out = subprocess.check_output(["conda", "env", "list", "--json"])
    d = json.loads(out.decode())
    return d['envs']

def get_orange3_env():
    envs = get_conda_envs()
    for env in envs:
        if os.path.basename(env) == 'orange3':
            return env

print(get_orange3_env())
