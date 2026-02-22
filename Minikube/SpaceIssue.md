
 growpart /dev/nvme0n1 4 ; lvextend -l +80%FREE /dev/mapper/RootVG-varVol ; xfs_growfs /var
 growpart /dev/nvme0n1 4 ; lvextend -l +100%FREE /dev/mapper/RootVG-homeVol ; xfs_growfs /home

 # LVM Out of Space
Situation - / or /var on LVM is full
Solution - 
lsblk           # lsblk means 
sudo vgs        # vgs means
sudo lvs        # lvs means 
sudo lvextend -L +10G /dev/<vg>/<lv>
sudo resize2fs /dev/<vg>/<lv>
# XFS:
sudo xfs_growfs /


`lvextend -l +80%FREE /dev/mapper/RootVG-varVol` ---->> Extend the logical volume by 80% of the VG’s free space 
`xfs_growfs /var` ---->> Expand the XFS filesystem to use the new space   online       
