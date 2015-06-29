#!/usr/bin/python
import os
import sys
from subprocess import call

project_name = os.path.basename(os.path.abspath('.'))
if len(sys.argv) == 3:
    service_name = sys.argv[2]
    unit = "%s-%s.docker-compose.service" % (project_name, service_name)
else:
    unit = "%s.docker-compose.target" % project_name

action = sys.argv[1]

action_map = {
    "start": "systemctl start %s",
    "status": "systemctl status %s",
    "stop": "systemctl stop %s",
    "kill": "systemctl kill %s",
    "logs": "journalctl -fu %s"
}
cmd = action_map[action] % unit

try:
    call(cmd, shell=True)
except:
    pass
