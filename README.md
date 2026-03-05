# jhelb1993's ebuilds

Here some private ebuilds for myself!

Current ebuilds:
- manaplus

### How to use this repo

```
sudo mkdir -p /var/db/repos/gentoo-ebuilds
sudo git clone https://github.com/jhelb1993/gentoo-ebuilds /var/db/repos/gentoo-ebuilds

sudo mkdir -p /etc/portage/repos.conf
sudo tee /etc/portage/repos.conf/gentoo-ebuilds.conf >/dev/null <<'EOF'
[gentoo-ebuilds]
location = /var/db/repos/gentoo-ebuilds
masters = gentoo
auto-sync = no
EOF
```
