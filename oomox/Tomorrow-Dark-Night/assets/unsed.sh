#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#1d1f21/g' \
         -e 's/rgb(100%,100%,100%)/#e0e0e0/g' \
    -e 's/rgb(50%,0%,0%)/#1d1f21/g' \
     -e 's/rgb(0%,50%,0%)/#81a2be/g' \
 -e 's/rgb(0%,50.196078%,0%)/#81a2be/g' \
     -e 's/rgb(50%,0%,50%)/#282a2e/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#282a2e/g' \
     -e 's/rgb(0%,0%,50%)/#e0e0e0/g' \
	$@