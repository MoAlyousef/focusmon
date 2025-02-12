# FocusMon

A small windows utility which tries to track which application grabbed current focus.
Useful for debugging Windows 10 and 11 issue of windows randomly losing focus!

## Building from source
FocusMon requires a recent Zig toolchain (0.14 dev with package manager support) as well as CMake. It also requires a system install of cfltk.

To install cfltk on msys2/mingw:
```
git clone https://github.com/MoAlyousef/cfltk --depth=1 --recurse-submodules && cd cfltk && ./scripts/bootstrap_common.sh
```

To build focusmon:
```
git clone https://github.com/MoAlyousef/focusmon
cd focusmon
zig build
```

![image](https://user-images.githubusercontent.com/37966791/216713278-92b20585-df58-41c8-99be-71312ba28b61.png)