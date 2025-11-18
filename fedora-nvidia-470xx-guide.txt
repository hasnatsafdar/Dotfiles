# Quick one-page doc — Install & verify NVIDIA **470xx** for (but not limited to) Thinkpad W530 (Quadro K1000M) — copy/paste ready
---

## Preflight

* Confirm GPU: `lspci | grep -i nvidia`
* Note kernel: `uname -r` (save it with your notes).
* Have internet + sudo.
* Backup any critical work (always).

---

## Copy-paste steps

1. **Add RPMFusion repos**

```bash
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

2. **Optional: update system**

```bash
sudo dnf upgrade -y
```

3. **Install the driver (no CUDA)**

```bash
sudo dnf install -y akmod-nvidia-470xx xorg-x11-drv-nvidia-470xx
```

If you want CUDA / `nvidia-smi` tools installed too (only if you need OpenCL/CUDA):

```bash
sudo dnf install -y akmod-nvidia-470xx xorg-x11-drv-nvidia-470xx xorg-x11-drv-nvidia-470xx-cuda
```

If you hit an OpenCL conflict, re-run the CUDA install with `--allowerasing`:

```bash
sudo dnf install -y xorg-x11-drv-nvidia-470xx-cuda --allowerasing
```

4. **Force akmods build (optional; usually akmods will run at boot)**

```bash
sudo akmods --kernels all
sudo dracut --force
```

5. **Reboot**

```bash
sudo reboot
```

6. **Verify the driver is active**

```bash
lspci -k | grep -EA3 'VGA|3D'
# should show: Kernel driver in use: nvidia

nvidia-smi
# should show your Quadro K1000M and driver version
```

---

## Quick troubleshooting (if things go sideways)

* Nouveau still loaded → create blacklist and rebuild initramfs:

```bash
echo -e "blacklist nouveau\noptions nouveau modeset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
sudo dracut --force
sudo reboot
```

* View kernel / module errors:

```bash
sudo dmesg | grep -i nvidia
sudo journalctl -b | grep -i nvidia
```

* If system won’t boot after a bad driver: at GRUB press `e`, add `nomodeset` to kernel line, boot, then remove/reinstall driver packages.

* To remove/rollback drivers:

```bash
sudo dnf remove -y akmod-nvidia-470xx 'xorg-x11-drv-nvidia-470xx*'
sudo dracut --force
sudo reboot
```

---

## Use NVIDIA only when needed (Prime Render Offload) — make `prime-run` script

Make launching GPU apps easy:

```bash
sudo tee /usr/local/bin/prime-run > /dev/null <<'EOF'
#!/bin/sh
env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only "$@"
EOF
sudo chmod +x /usr/local/bin/prime-run
```

Usage:

```bash
prime-run minecraft-launcher
prime-run steam
prime-run glxinfo | grep "OpenGL renderer"
```

---

## Small checklist to save in your docs (very important)

* Kernel version: `uname -r`
* `nvidia-smi` output (driver version + CUDA)
* `lspci -k` output line for NVIDIA
* Exact `dnf` commands used + date
* If you used `--allowerasing`, note what was removed (DNF prints it)
