if which apt-get > /dev/null 2>&1; then pm=$(which apt-get); silent_inst="-yq install"; check_pkgs="-yq update"; docker_pkg="docker.io"; dist="debian";\
elif which dnf > /dev/null 2>&1; then pm=$(which dnf); silent_inst="-yq install"; check_pkgs="-yq check-update"; docker_pkg="docker"; dist="fedora";\
elif which yum > /dev/null 2>&1; then pm=$(which yum); silent_inst="-y -q install"; check_pkgs="-y -q check-update"; docker_pkg="docker"; dist="centos";\
else echo "Packet manager not found"; exit 1; fi;\
echo "Dist: $dist, Packet manager: $pm, Install command: $silent_inst, Check pkgs command: $check_pkgs, Docker pkg: $docker_pkg";\
if [ "$dist" = "debian" ]; then export DEBIAN_FRONTEND=noninteractive; fi;\
if ! command -v sudo > /dev/null 2>&1; then $pm $check_pkgs; $pm $silent_inst sudo; fi;\
if ! command -v fuser > /dev/null 2>&1; then sudo $pm $check_pkgs; sudo $pm $silent_inst psmisc; fi;\
if ! command -v lsof > /dev/null 2>&1; then sudo $pm $check_pkgs; sudo $pm $silent_inst lsof; fi;\
if ! command -v docker > /dev/null 2>&1; then \
  if [ "$dist" = "centos" ]; then \
    CHECK_FILE=/etc/yum/pluginconf.d/subscription-manager.conf;\
    if [ -f "$CHECK_FILE" ]; then CHANGE_NEED=0; else CHANGE_NEED=1; fi;\
  fi;\
  sudo $pm $check_pkgs; sudo $pm $silent_inst $docker_pkg;\
  if [ "$dist" = "centos" ] && [ "$CHANGE_NEED" = "1" ];\
  then echo -e "[main]\nenabled=0" > $CHECK_FILE; fi;
  sleep 5; sudo systemctl enable --now docker; sleep 5;\
fi;\
if [ "$(systemctl is-active docker)" != "active" ]; then \
  sudo $pm $check_pkgs; sudo $pm $silent_inst $docker_pkg;\
  sleep 5; sudo systemctl start docker; sleep 5;\
fi;\
if ! command -v sudo > /dev/null 2>&1; then echo "Failed to install sudo, command not found"; exit 1; fi;\
docker --version
