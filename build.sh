#!/bin/sh

wget -O ./public/radar.gif https://weather.tmd.go.th/cmp/cmp240_latest.gif
wget -O ./public/cmp1.gif https://weather.tmd.go.th/cmp/cmp1.gif
wget -O ./public/cmp1.gif https://weather.tmd.go.th/cmp/cmp2.gif
wget -O ./public/cmp3.gif https://weather.tmd.go.th/cmp/cmp3.gif
wget -O ./public/cmp4.gif https://weather.tmd.go.th/cmp/cmp4.gif
wget -O ./public/cmp5.gif https://weather.tmd.go.th/cmp/cmp5.gif
wget -O ./public/cmp6.gif https://weather.tmd.go.th/cmp/cmp6.gif

emacs -Q --script build-site.el
