#!/bin/sh

killall -9 mwc
rm -rf ~/.mwc/floo/chain_data
cp -rp /media/ubuntu/*/node-files/chain_data ~/.mwc/floo
mwc --floonet
