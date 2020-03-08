#!/bin/bash

c=0
for file in "/media/ubuntu"/*
do
echo $file;
  eval "var$c='$file'";
  c=$((c+1));
done
cd /media/ubuntu;

dir=$var0;

echo -n "Specify USB Directory [$var0]: ";
read -r input


if [ ! -z "$input" ]
then
eval "dir=$input";
fi

if [ ! -d "$dir" ]
then
echo "Invalid directory. Exiting!";
exit 1
fi

cd ~
killall -q -9 mwc

mkdir -p ~/bin
cd ~

cd "$dir/"
cp mwc* ~/bin

cd ~/bin

tar zxvf mwc-node-3.1.1-linux-amd64.tar.gz
tar zxvf mwc-wallet-2.4.5-linux-amd64.tar.gz 
tar zxvf mwc713-2.4.8-linux-amd64.tar.gz

mv mwc mwc1
mv mwc713 mwc7131
mv mwc-wallet mwc-wallet1

mv mwc1/mwc .
mv mwc7131/mwc713 .
mv mwc-wallet1/mwc-wallet .

rm -rf mwc1 mwc7131 mwc-wallet1 *.tar.gz

if grep --quiet PATH ~/.bashrc;
then
echo "already set path";
. ~/.bashrc
else
echo "export PATH=$PATH:/home/ubuntu/bin" >> ~/.bashrc;
export PATH=$PATH:/home/ubuntu/bin;
fi

mkdir -p ~/.mwc/main
cd ~/.mwc/main
mwc server config
perl -pi -e 's/run_tui = true/run_tui = false/g' ~/.mwc/main/mwc-server.toml
echo "1337" > ~/.mwc/main/.api_secret
rm -rf ~/.mwc/main/chain_data
cp -pr "$dir"/node-files/chain_data ~/.mwc/main
mwc &
sleep 1

echo -n "How many mwc-wallet instances? "
read -r MWCWALLETCOUNT;

i="1";

while [ $i -le $MWCWALLETCOUNT ]
do
  mkdir -p ~/mwcwallets/$i

  cd ~/mwcwallets/$i
  export MWC_PASSWORD="";

  echo -n "Would you like to recover mwc-wallet $i from a mnemonic? [y/n] ";
  read -r input;


  echo "1337" > .api_secret

if [ ! -z "$input" ]
then
  eval "$input=y";
fi

if [  "$input" == "y" ]
then
  echo -n "Input mwc-wallet $i mnemonic: ";
  read -r MNEMONIC;
  export MWC_RECOVERY_PHRASE="$MNEMONIC";
  export MWC_PASSWORD="";
  mwc-wallet init -h -r
  unset MWC_PASSWORD
  unset MWC_RECOVERY_PHRASE
  echo "" | mwc-wallet restore
else
  mwc-wallet init -h
fi

  unset MWC_PASSWORD;

  let "i=i+1";
done

cd ~

echo -n "How many mwc713 instances? "
read -r MWC713COUNT;

i="1";

while [ $i -le $MWC713COUNT ]
do
  mkdir -p ~/mwc713wallets/$i;

  tee -a ~/mwc713wallets/$i/config <<EOM
chain = "Mainnet"
wallet713_data_path = "wallet713_data"
keybase_binary = "keybase"
mwcmq_domain = "mq.mwc.mw"
mwc_node_uri = "http://localhost:3413"
mwc_node_secret = "1337"
default_keybase_ttl = "24h"
grinbox_listener_auto_start = false
EOM

  echo -n "Would you like to recover mwc713 $i from a mnemonic? [y/n] ";
  read -r input;

  if [ ! -z "$input" ]
  then
    eval "$input=y";
  fi

if [ "$input" == "y" ]
then


  echo -n "Input mwc713 wallet $i mnemonic: ";
  read -r MNEMONIC;

mwc713 -c ~/mwc713wallets/$i/config recover --mnemonic "$MNEMONIC" <<EOM

EOM
  else

mwc713 -c ~/mwc713wallets/$i/config init <<EOM


EOM
  fi
  let "i=i+1";
done


echo "Please remember to run # . ~/.bashrc";

