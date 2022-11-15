#!/bin/bash
vpc=$(sed -n 4p zx.sh | cut -c 10- )
pub1=$(sed -n 2p zx.sh | cut -c 21- | sed 's/.........................$//' | sed  's/.$/"/')
pub2=$(sed -n 2p zx.sh | cut -c 47-  |sed 's/^/"/')
pri1=$(sed -n 1p zx.sh | cut -c 22- | sed 's/.........................$//' |sed  's/.$/"/')
pri2=$(sed -n 1p zx.sh | cut -c 48-  |sed 's/^/"/')
quotepub=$(sed -n 2p zx.sh | cut -c 22- | sed 's/..........................$//')
quotepri=$(sed -n 1p zx.sh | cut -c 23- | sed 's/..........................$//')
sed -i "10s/.*/  id: $vpc/" eks.yaml
sed -i "14s/.*/        id: $pub1/" eks.yaml
sed -i "17s/.*/        id: $pub2/" eks.yaml
sed -i "21s/.*/        id: $pri1/" eks.yaml
sed -i "24s/.*/        id: $pri2/" eks.yaml

sed -i "94s/.*/      - $quotepub/" eks.yaml
sed -i "81s/.*/      - $quotepri/" eks.yaml
