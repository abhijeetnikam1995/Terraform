#!/bin/bash
vpc=$(sed -n 4p zx.sh | cut -c 10- )
pub=$(sed -n 2p zx.sh | cut -c 21- | sed 's/.........................$//' | sed  's/.$/"/')
pri=$(sed -n 1p zx.sh | cut -c 22- | sed 's/.........................$//' |sed  's/.$/"/')
pub1=$(sed -n 2p zx.sh | cut -c 22- | sed 's/..........................$//')
pub2=$(sed -n 2p zx.sh | cut -c 22- | sed 's/..........................$//')
sed -i "10s/.*/  id: $vpc/" eks.yaml
sed -i "14s/.*/        id: $pub/" eks.yaml
sed -i "17s/.*/        id: $pub/" eks.yaml
sed -i "21s/.*/        id: $pri/" eks.yaml
sed -i "24s/.*/        id: $pri/" eks.yaml

sed -i "81s/.*/      - $pub1/" eks.yaml
sed -i "94s/.*/      - $pub2/" eks.yaml
