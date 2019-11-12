#!/bin/sh

killall -9 mwc
rm -rf ~/.mwc/main/chain_data
cp -rp /media/ubuntu/*/node-files/chain_data ~/.mwc/main
mwc &
