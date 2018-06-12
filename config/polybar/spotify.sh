#!/usr/bin/env bash

artist=$(echo -n $(playerctl metadata artist))
song=$(echo -n $(playerctl metadata title))

echo -n "$artist - $song"
