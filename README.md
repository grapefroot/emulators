# Emulator launchers

This directory contains standalone flakes for macOS and Linux. They do not
modify the system configuration in the parent repository.

## Apple Silicon Mac

Run OpenEmu-Silicon from the `mac` flake:

```sh
nix run ./mac
```

The app comes from the community-maintained Nix User Repository (NUR). On its
first launch, install the cores in the setup assistant or under
**OpenEmu → Preferences → Cores**. For PlayStation, install Mednafen and add a
BIOS dump from your own console by dragging it into the OpenEmu library.

## Linux

Run RetroArch with the Beetle PSX HW core from the `linux` flake:

```sh
nix run ./linux -- /path/to/game.cue
```

The flake targets `x86_64-linux`. Put a BIOS dump from your own console in
RetroArch's System/BIOS directory; RetroArch shows the active directory under
**Settings → Directory → System/BIOS**.

Each subdirectory is an independent flake. The first `nix run` will create a
`flake.lock` in that subdirectory to pin its inputs.
