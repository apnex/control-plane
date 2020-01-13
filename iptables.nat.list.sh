#!/bin/bash

iptables -t nat -L -v -n --line-numbers
