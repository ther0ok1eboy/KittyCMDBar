## [Kitty Command Bar](https://github.com/ther0ok1eboy/KittyCMDBar) - The ultimate solution for status bar inlining to terminals

<center><img src="https://raw.githubusercontent.com/ther0ok1eboy/KittyCMDBar/master/src/demo.png"></center>

[中文版](./README_cn.md)

One night when I was sleeping I was thinking that it would be nice to have a status bar like [waybar](https://github.com/Alexays/Waybar) and [kitty](https://github.com/kovidgoyal/kitty) terminal together on the desktop, with the status bar at the top and the terminal filling up the desktop below it, and everything would look so nice, but when I quit the terminal, only the status bar would be left hanging on the top of the desktop, which would look really stupid. Is there a status bar that only appears when the terminal appears and hides when the terminal exits? I didn't seem to find a good solution, so I started trying to display some information to the terminal when it's open.

## Feature

- The source code is simple and highly customizable.
- Dynamic display and interactive.
- Customizable functions in response to mouse click events.

## Requirements
- nerd-font
- kitty
- tput
- hyprctl
- brightnessctl
- pactl
- upower
- nmcli
- playerctl

## Support

| terminal  | OS   | support |
|-----------|------|---------|
| kitty     | Arch | ✅      |
| alacritty | Arch | ❌      |



## License

[KittyCMDBar](https://github.com/ther0ok1eboy/KittyCMDBar) is MIT-licensed. For more information check the [LICENSE](LICENSE) file.
