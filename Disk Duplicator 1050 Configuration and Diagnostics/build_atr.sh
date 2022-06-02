#!/bin/bash

if [ ! -d /tmp/atr ];
then
	mkdir /tmp/atr
else
	rm -rf /tmp/atr/*
fi

cp ./DOS.SYS /tmp/atr/
cp ./DUP.SYS /tmp/atr/
cp ./DD1050.xex /tmp/atr/DD1050.EXE
cp ./DD1050.xex /tmp/atr/AUTORUN.SYS

dir2atr -b Dos25 720 /tmp/dd1050.atr /tmp/atr/
cp /tmp/dd1050.atr .
