echo -e "\033[36m"
echo -e "\033[36m░░\033[36m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\033[36m░░"
echo -e "\033[36m░░\033[33m██░░░░░░░░░██╗░██████╗░██████╗░████████╗░██████╗░██████╗░░███████╗\033[36m░░"
echo -e "\033[36m░░\033[33m██░░░░░░░░░██║░██╔═══╝░██╔═══╝░╚══██╔══╝░██╔═══╝░██╔══██╗░╚██═╗██║\033[36m░░"
echo -e "\033[36m░░\033[33m╚██░░░█░░░██═╝░██████╗░██████░░░░░██║░░░░██████╗░██████╔╝░░██░║██║\033[36m░░"
echo -e "\033[36m░░\033[33m░╚██░███░██╝░░░██╔═══╝░░░╚═██╗░░░░██║░░░░██╔═══╝░██╔══██╗░░██░║██║\033[36m░░"
echo -e "\033[36m░░\033[33m░░╚██╔══██║░░░░██████╗░██████║░░░░██║░░░░██████╗░██║░░██║░░██░║██║\033[36m░░"
echo -e "\033[36m░░\033[33m░░░╚═╝░░╚═╝░░░░╚═════╝░╚═════╝░░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝░░░░░╚══╝\033[36m░░"
echo -e "\033[36m░░\033[36m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\033[36m░░"
echo -e "\033[32m"

echo -e "\033[35m" 
echo -e "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$"
echo -e "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\033[36m  https://t.me/westernchat  \033[35m\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$"
echo -e "\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$\$"
echo -e ""
echo -e "\033[32m"

sudo apt update && sudo apt install curl -y &&

#!/bin/sh
set -e

CLEAN_FLAG=''
PORT=''
HOST=''
HOME="/home/minima"
CONNECTION_HOST=''
CONNECTION_PORT=''
SLEEP=''
RPC=''

print_usage() {
  printf "Usage: Setups a new minima service for the specified port"
}

while getopts ':xsc::p:r:d:h:' flag; do
  case "${flag}" in
    s) SLEEP='true';;
    x) CLEAN_FLAG='true';;
    r) RPC="${OPTARG}";;
    c) CONNECTION_HOST=$(echo $OPTARG | cut -f1 -d:);
       CONNECTION_PORT=$(echo $OPTARG | cut -f2 -d:);;
    p) PORT="${OPTARG}";;
    d) HOME="${OPTARG}";;
    h) HOST="${OPTARG}";;
    *) print_usage
       exit 1 ;;
  esac
done

apt update
apt install openjdk-11-jre-headless -y

if [ ! $(getent group minima) ]; then
  echo "[+] Adding minima group"
  groupadd -g 9001 minima
fi

if ! id -u 9001 > /dev/null 2>&1; then
  echo "[+] Adding minima user"
    useradd -r -u 9001 -g 9001 -d $HOME minima
    mkdir $HOME
    chown minima:minima $HOME
fi

wget -q -O $HOME"/minima_service.sh" "https://github.com/minima-global/Minima/raw/master/scripts/minima_service.sh"
chown minima:minima $HOME"/minima_service.sh"
chmod +x $HOME"/minima_service.sh"

CMD="$HOME/minima_service.sh -s $@"
CRONSTRING="#!/bin/sh
$CMD"

echo "$CRONSTRING" > /etc/cron.weekly/minima_$PORT
chmod a+x /etc/cron.weekly/minima_$PORT

CMD="$HOME/minima_service.sh $@"
/bin/sh -c "$CMD"

echo -e "\033[36m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" 
echo -e "\033[33m░░░░░░░░░Install complete░░░░░░░░░"
echo -e "\033[36m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" 
#journalctl -fn 10 -u minima_$PORT

#wget -O minima_setup.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_setup.sh && 
#chmod +x minima_setup.sh && sudo ./minima_setup.sh -r 9002 -p 9001

echo -e "\n"

echo -e "\033[36m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" 
echo -e "\033[33m░ Переходьте до наступного пункту ░" 
echo -e "\033[36m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" 

