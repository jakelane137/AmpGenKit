#!/usr/bin/env bash

export AMPGENKIT=$(readlink -f "$0")
export AMPGENKIT=$(dirname "$AMPGENKIT")
export PATH=$PATH:$AMPGENKIT/scripts
export PYTHONPATH=$AMPGENKIT/python:$PYTHONPATH



