import subprocess

def ExecuteCommand(cmd:list, mute:bool):
    print('Executing: ', end='')
    for x in cmd:
        print(x, end=' ')
    print()
    dump = subprocess.run(
        cmd , capture_output=True, text=True
    )
    if not mute and len(dump.stdout) != 0:
        print('stdout: ' + dump.stdout)
    if len(dump.stderr) != 0:
        print('stderr: '+ dump.stderr)
    return dump
