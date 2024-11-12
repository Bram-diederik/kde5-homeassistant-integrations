This authorized keys addition allows sending a virsh command over ssh
`command="virsh -c qemu:///system $SSH_ORIGINAL_COMMAND",no-agent-forwarding,no-X11-forwarding,no-pty <your ssh key>`


add a command in /config/bin/ in home assistant 
```
#!/bin/bash
ssh -i /config/ssh/libvirt user@virshhost $@
```

```
shell_command:
   virsh: "/config/bin/virsh.sh {{command}}"
```

you can now run any libvirt shell command with virsh on the home assistant machine. Like turing on/off VMs
