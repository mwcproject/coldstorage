# Overview

This project allows the user to easily configure a cold storage USB stick for Ubuntu 18.04.3.

# Prerequisites

You will need an x64 laptop or desktop that has two USB drives or more. Generally speaking most pc/mac/linux hardware will work. You also need two USB sticks. The first USB stick will contain Ubuntu 18.04.03 or later (requires 2 GB+ of storage space). You can find instructions for installing this here: https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-ubuntu#0. The second USB stick will contain the scripts and binaries to setup mwc-wallet, mwc-node, and mwc713 in order to be able to generate seeds and transact. This USB stick will also contain the MWC chain state. Currently for testnet almost any size will be fine since the chain state is very small, but at some point a larger size might be required. I suggest getting a 128 GB stick for now which will be sufficient for the foreseable future and since they cost about $25 or less it is fairly reasonable. These instructions also assume you have an mwc full node running on the system you are working on. Instructions for setting up an mwc-node can be found here: https://github.com/mwcproject/mwc-node.

# Setup

1.) Follow the Ubuntu tutorial for creating a bootable USB stick Ubuntu instance: https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-ubuntu#0

2.) Checkout the project:

```# git clone https://github.com/mwcproject/coldstorage```

3.) Insert your second USB stick and ensure it is empty. If it is not delete any existing files on it.

4.) Copy the files in the files directory the USB stick:

```# cp -rp ./coldstorage/files/* <location_of_usb_drive>```

For example:

```# cp -rp ./coldstorage/files/* /Volumes/NO\ NAME/```

5.) Next, copy the chain_data from your MWC full node onto the usb drive into the 'node-files' directory. By default, your
MWC full node's chain_data directory will be in ~/.mwc/main/chain_data, but copy them from wherever they are located if you did not use the defaults. Also, make sure to shut down your full node before copying the chain_data over:

```# cp -rp ~/.mwc/main/chain_data <location_of_usb_drive>/node_files/```

6.) Boot your USB stick OS so that you are in Ubuntu Linux.

IMPORTANT: Do not configure networking as that will compromize the cold storage nature of the setup.

7.) Once you are in Ununtu, open a terminal and copy the setup.sh script over to your home directory:

```# cp /media/ubuntu/<your_usb_device>/setup.sh .```

8.) Change the permissions on the setup.sh script:

```# chmod 755 setup.sh```

9.) Execute the setup.sh:

```# ./setup.sh```

10.) The script will take you through a set of questions that should be fairly straight forward. It will allow you to install any number of mwc-wallet instances and mwc713 instances. You can choose to recover from a mnemonic or generate new seeds. If you generate seeds you will want to write down your seeds on paper for later use. Since this an offline wallet, you will need to follow the procedure here to finalize and submit transactions to the network: https://github.com/mwcproject/mwc-node/blob/master/doc/offline_wallet.md
