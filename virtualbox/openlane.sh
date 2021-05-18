#!/bin/bash
export TOOLS_ROOT="/home/$(whoami)/asic_tools"

cd $TOOLS_ROOT

git clone https://github.com/efabless/caravel_user_project.git
export PDK_ROOT=$(pwd)/pdk
export OPENLANE_ROOT=$(pwd)/openlane
export OPENLANE_TAG=v0.15

cd caravel_user_project
git checkout mpw-two-c
export CARAVEL_ROOT=$(pwd)/caravel

make install    # install caravel
make pdk        # build pdk
make openlane   # build openlane

make user_proj_example
