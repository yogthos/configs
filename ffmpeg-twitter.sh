#!/bin/bash
ffmpeg -i $input -vcodec libx264 -pix_fmt yuv420p -strict -2 -acodec aac ${input%.*}.mp4
