#!/usr/bin/env bash

# Power Management
yay --noconfirm -S auto-cpufreq
sleep 0.5
sudo systemctl enable auto-cpufreq.service

sleep 0.5

# Graphic Drivers
# pacman --noconfirm -S mesa vulkan-radeon vulkan-intel vulkan-nouveau xf86-video-amdgpu xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-vmware intel-media-driver libva-intel-driver libva-mesa-driver

# My Apps
