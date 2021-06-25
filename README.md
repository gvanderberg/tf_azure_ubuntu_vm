# tf_ubuntu_agents_vm

[Attach data disk to Linux VM](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal)

## Find the disk

Use `lsblk` to list the disks. 

```bash
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```

### Partition a new disk

The `parted` utility can be used to partition and to format a data disk.

The following example uses `parted` on `/dev/sdc`.

```bash
sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1
```

### Mount the disk

Create a directory to mount the file system using `mkdir`. The following example creates a directory at `/data`:

```bash
sudo mkdir /data
```

Use `mount` to then mount the filesystem. The following example mounts the */dev/sdc1* partition to the `/datadrive` mount point:

```bash
sudo mount /dev/sdc1 /data
```

To ensure that the drive is remounted automatically after a reboot, it must be added to the */etc/fstab* file. It is also highly recommended that the UUID (Universally Unique Identifier) is used in */etc/fstab* to refer to the drive rather than just the device name (such as, */dev/sdc1*). To find the UUID of the new drive, use the `blkid` utility:

```bash
sudo blkid
```

The output looks similar to the following example:

```bash
/dev/sda1: LABEL="cloudimg-rootfs" UUID="11111111-1b1b-1c1c-1d1d-1e1e1e1e1e1e" TYPE="ext4" PARTUUID="1a1b1c1d-11aa-1234-1a1a1a1a1a1a"
/dev/sda15: LABEL="UEFI" UUID="BCD7-96A6" TYPE="vfat" PARTUUID="1e1g1cg1h-11aa-1234-1u1u1a1a1u1u"
/dev/sdb1: UUID="22222222-2b2b-2c2c-2d2d-2e2e2e2e2e2e" TYPE="ext4" TYPE="ext4" PARTUUID="1a2b3c4d-01"
/dev/sda14: PARTUUID="2e2g2cg2h-11aa-1234-1u1u1a1a1u1u"
/dev/sdc1: UUID="33333333-3b3b-3c3c-3d3d-3e3e3e3e3e3e" TYPE="xfs" PARTLABEL="xfspart" PARTUUID="c1c2c3c4-1234-cdef-asdf3456ghjk"
```

Next, open the */etc/fstab* file in a text editor as follows:

```bash
sudo vi /etc/fstab
```

In this example, use the UUID value for the `/dev/sdc1` device that was created in the previous steps, and the mountpoint of `/data`. Add the following line to the end of the `/etc/fstab` file:

```bash
UUID=33333333-3b3b-3c3c-3d3d-3e3e3e3e3e3e   /data   xfs   defaults,nofail   1   2
```

## Verify the disk

You can now use `lsblk` again to see the disk and the mountpoint.

```bash
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```
