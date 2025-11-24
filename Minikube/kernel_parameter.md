> COMMAND - sysctl fs.protected_regular
is used to modify a kernel parameter at runtime.


sysctl
A utility to view or change kernel parameters (usually found under /proc/sys).

fs.protected_regular
This is a kernel parameter that controls protection of regular files (like normal data files) against being modified or deleted through certain privileged operations, even by root, under specific conditions.

🔒 What fs.protected_regular does

When enabled (=1), it prevents unprivileged users (and sometimes even root, in indirect ways) from performing dangerous operations on regular files that are hardlinked or shared between users — for example:

Preventing overwriting or deletion of system files via hardlinks.

Mitigating privilege-escalation attacks using hardlinks and temporary files.

| Value | Meaning                                                                     |
| ----- | --------------------------------------------------------------------------- |
| `0`   | Protection is **disabled** — the kernel does not restrict these operations. |
| `1`   | Protection is **enabled** — normal, more secure behavior.                   |

View current setting : sysctl fs.protected_regular
Set (temporarily)    : sudo sysctl fs.protected_regular=0
Re-enable protection : sudo sysctl fs.protected_regular=1

⚠️ Security Implication

Setting: sysctl fs.protected_regular=0

lowers system security. It should only be done temporarily and only for specific compatibility reasons (e.g., some container or legacy app issues).

Re-enable it afterward: sysctl fs.protected_regular=1

To make the change temporary, it affects only the running system.
To make it permanent, you’d add it to /etc/sysctl.conf or a file under /etc/sysctl.d/.
Don’t add it permanently to /etc/sysctl.conf unless you fully control and trust all local users.


⚙️ Why fs.protected_regular=0 Might Be Used

🐳 1. Container or chroot environments
In Docker, LXC, or chroot environments, you might have:
Shared file systems between the host and the container.
Processes running as “root” inside the container, but not truly privileged on the host.

🧱 2. Legacy software or build systems
Older build scripts or packaging systems (like RPM or some makefiles) assume they can freely overwrite files linked across directories.
The protection blocks that, breaking builds or installs.



`lvextend -l +80%FREE /dev/mapper/RootVG-varVol` ---->> Extend the logical volume by 80% of the VG’s free space 
`xfs_growfs /var` ---->> Expand the XFS filesystem to use the new space   online       
