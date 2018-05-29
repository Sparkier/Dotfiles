# Arch Linux

I'm a Ph. D. student at Ulm University. There I use Arch/i3 as my computer setup. When I began with my Ph. D. on machine learning visualization, I was using Ubuntu on my workstation. However, Ubuntu proved to be unstable whilst also not being visually appealing. Therefore I switched to Arch/i3 with a rather minimalistic design which I really learned to like a lot. Tiling window management along with workspaces is a charm to work with.

However, Arch involves a lot of configuration work. These are the configurations for this computer.

## i3

As already mentioned, I use i3 as my window manager. This proved to be a really good guide to i3: [i3 Guide](https://i3wm.org/docs/userguide.html). What I changed for my configuration is basically remapping of some of the keys to kind of match my Mac habits. Rename some of the workspaces to my preferences and attach icons to them and define my very simplistic color scheme. I also defined some rules abour applications that should launch on startup and applications that should automatically be moved to certain workspaces. For my status bar, I added a clock and an audio control widget through [i3pystatus](https://github.com/enkore/i3pystatus). So nothing fancy here.

## Xmodmap

I also wanted to remap my keyboard to - again - kind of match the Mac layout. This was done throug my xprofile and Xmodmap.