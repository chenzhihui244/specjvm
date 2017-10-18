#!/bin/sh

yum install -y java-1.8.0-openjdk
apt install -y libfreetype-dev
apt install -y fontconfig-dev
java -jar SPECjvm2008_1_01_setup.jar -i console
