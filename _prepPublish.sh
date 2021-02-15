#!/bin/bash
echo Copying output to docs folder...
rm -rf docs
mkdir docs
cp -R output/. docs