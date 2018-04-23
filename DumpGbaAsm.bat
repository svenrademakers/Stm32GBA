@echo off
arm-none-eabi-g++.exe -march=armv4t -mcpu=arm7tdmi -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -mthumb -mthumb-interwork -nostartfiles %*
arm-none-eabi-objdump.exe -D a.out
rm a.out