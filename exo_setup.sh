#!/bin/bash 

cd
sudo apt update -y 
sudo apt install python3.12-full git libgl1-mesa-dev clang -y
mkdir workspace
cd workspace

git clone https://github.com/exo-explore/exo
cd exo
git checkout 017bf93cf58486f10d802a81cff4a887673411b3

python3 -m venv .venv
source .venv/bin/activate
pip install .
