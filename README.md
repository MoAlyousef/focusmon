# FocusMon

A small windows utility which tries to track which application grabbed current focus.
Useful for debugging Windows 10 and 11 issue of windows randomly losing focus!

## Building from source
FocusMon requires a Zig toolchain as well as CMake. No other dependencies are needed on Windows.
```
git clone https://github.com/MoAlyousef/focusmon --recurse-submodules
cd focusmon
CC="zig cc" CXX="zig c++" zig build
```

![image](https://user-images.githubusercontent.com/37966791/215907392-9de27f5b-ca48-4a9b-868f-bd7e09058437.png)