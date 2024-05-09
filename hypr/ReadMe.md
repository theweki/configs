# VARIABLE 
    $<var-name> = <literal>

# KEYWORDS
    source, env, layerrule

# CONFIGURATIONS

## Monitors
    monitor = name, resolution, position, scale
    e.g., monitor = eDP-1, 1920x1080@144, 0x0, 1
List all Monitors using ``` hyprctl monitors all ``` 

## Binds
    bind = MODS, key, dispatcher, params
    e.g., 
            bind = SUPER, Q, exec, kitty
            bind = , Print, exec, grim

### key

#### KEYBOARD
    keycode e.g., code:28 for T
    
#### Mouse
    mouse keycode e.g., mouse:272 for LMB
    mouse wheel e.g., mouse_(up|down|left|right)

#### Switches
Use this to find all switch codes - ```hyprctl devices```

    switch:(|on|off):[switch name]

    Useful for binding e.g. the lid close/open event:

    # trigger when the switch is toggled
    bindl=,switch:[switch name],exec,swaylock
    
    # trigger when the switch is turning on
    bindl=,switch:on:[switch name],exec,hyprctl keyword monitor "eDP-1, disable"
    

#### Bind Flags
    bind[flags] = ...
    e.g., bindrl = MOD, KEY, exec, amongus

    Flags:
        l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
        r -> release, will trigger on release of a key.
        e -> repeat, will repeat when held.
        n -> non-consuming, key/mouse events will be passed to the active window in addition triggering the dispatcher.
        m -> mouse, [see Mouse Binds]
        t -> transparent, cannot be shadowed by other binds.
        i -> ignore mods, will ignore modifiers.

    e.g., 
        # Example volume button that allows press and hold, volume limited to 150%
        binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+

        # Example volume button that will activate even while an input inhibitor is active
        bindl = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

        # Start wofi opens wofi on first press, closes it on second
        bindr = SUPER, SUPER_L, exec, pkill wofi || wofi

#### Mouse Binds
    bindm = ALT, mouse:272, movewindow

    LMB -> 272
    RMB -> 273

    Available Mouse Binds - 
        movewindow
        resizewindow

#### Touchpad
    As clicking and moving the mouse on a touchpad is unergonomic, you can also use keyboard keys instead of mouse clicks too.

    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, Control_L, movewindow

    bindm = SUPER, mouse:273, resizewindow
    bindm = SUPER, ALT_L, resizewindow

#### Media
    bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

#### Submap
    Keybind submaps, also known as modes or groups, allow you to activate a seperate set of keybinds. For example, if you want to enter a “resize” mode which allows you to resize windows with the arrow keys, you can do it like this:

        # will switch to a submap called resize
        bind=ALT,R,submap,resize

        # will start a submap called "resize"
        submap=resize

        # sets repeatable binds for resizing the active window
        binde=,right,resizeactive,10 0
        binde=,left,resizeactive,-10 0
        binde=,up,resizeactive,0 -10
        binde=,down,resizeactive,0 10

        # use reset to go back to the global submap
        bind=,escape,submap,reset 

        # will reset the submap, which will return to the global submap
        submap=reset

        # keybinds further down will be global again...
    
    You can also set the same keybind to perform multiple actions, such as resize and close the submap, like so:

        bind=ALT,R,submap,resize

        submap=resize

        bind=,right,resizeactive,10 0
        bind=,right,submap,reset
        # ...

        submap=reset

### dispatchers
    See https://wiki.hyprland.org/Configuring/Dispatchers/ for dispatcher and params

# Animations

    animation = NAME, ONOFF, SPEED, CURVE[, STYLE]

    ONOFF can be either 0 or 1, 0 to disable, 1 to enable. note: if it’s 0, you can omit further args.
    SPEED is the amount of ds (1ds = 100ms) the animation will take
    CURVE is the bezier curve name, see curves.
    STYLE (optional) is the animation style

    e.g., 
        animation = workspaces, 1, 8, default
        animation = windows, 1, 10, myepiccurve, slide
        animation = fade, 0

## Animation Tree

    global
        ↳ windows - styles: slide, popin
            ↳ windowsIn - window open
            ↳ windowsOut - window close
            ↳ windowsMove - everything in between, moving, dragging, resizing.
        ↳ layers - styles: slide, popin, fade
            ↳ layersIn - layer open
            ↳ layersOut - layer close
        ↳ fade
            ↳ fadeIn - fade in for window open
            ↳ fadeOut - fade out for window close
            ↳ fadeSwitch - fade on changing activewindow and its opacity
            ↳ fadeShadow - fade on changing activewindow for shadows
            ↳ fadeDim - the easing of the dimming of inactive windows
            ↳ fadeLayers - for controlling fade on layers
            ↳ fadeLayersIn - fade in for layer open
            ↳ fadeLayersOut - fade out for layer close
        ↳ border - for animating the border's color switch speed
        ↳ borderangle - for animating the border's gradient angle - styles: once (default), loop
        ↳ workspaces - styles: slide, slidevert, fade, slidefade, slidefadevert
            ↳ specialWorkspace - styles: same as workspaces

##  Curves

    Defining your own Bezier curve can be done with the bezier keyword:

    bezier = NAME, X0, Y0, X1, Y1

    where NAME is the name, and the rest are two points for the Cubic Bezier. 
    A good website to design your bezier can be found here, on [ cssportal.com ] 
    But if you want to instead choose from a list of beziers, you can check out [ easings.net ]

    e.g., bezier = overshot, 0.05, 0.9, 0.1, 1.1

### Extras
    For animation style popin in windows, you can specify a minimum percentage to start from. For example, the following will make the animation 80% -> 100% of the size:

        animation = windows, 1, 8, default, popin 80%

    For animation styles slidefade and slidefadevert in workspaces, you can specify a movement percentage. For example, the following will make windows move 20% of the screen width:

        animation = workspaces, 1, 8, default, slidefade 20%

    For animation style slide in windows and layers you can specify a forced side, e.g.:

        animation = windows, 1, 8, default, slide left

    You can use top, bottom, left or right.

# XWayland

## HiDPI
    XWayland currently looks pixelated on HiDPI screens, due to Xorg’s inability to scale.

    FIX:
        # change monitor to high resolution, the last argument is the scale factor
        monitor=,highres,auto,2

        # unscale XWayland
        xwayland {
            force_zero_scaling = true
        }

        # toolkit-specific scale
        env = GDK_SCALE,2
        env = XCURSOR_SIZE,32

# EXAMPLE CONFIGURATIONS

``` https://wiki.hyprland.org/Configuring/Example-configurations/ ```

# How do I make Hyprland draw as little power as possible on my laptop?
```
decoration:blur = false
decoration:drop_shadow = false
misc:vfr = true
```

# HYPR ECOSYSTEM

hyprpaper - https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/

hyprpicker - https://wiki.hyprland.org/Hypr-Ecosystem/hyprpicker/

hypridle - https://wiki.hyprland.org/Hypr-Ecosystem/hypridle/

hyprlock - https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/

hyprcursor - https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor/

xdg-desktop-portal-hyprland - https://wiki.hyprland.org/Hypr-Ecosystem/xdg-desktop-portal-hyprland/


# MUST HAVE FOR SMOOTH HYPRLAND EXPERIENCE

## A Notification Daemon

Starting method: most likely manual (exec-once)

Many apps (e.g. Discord) may freeze without one running.

Examples: ```dunst```, ```mako```, and ```swaync```.

## Pipewire

Starting method: Automatic on systemd, manual otherwise.

Pipewire is not necessarily required, but screensharing will not work without it.

Install ```pipewire``` and ```wireplumber``` (not ```pipewire-media-session```).

## XDG Desktop Portal 

Starting method: Automatic on systemd, manual otherwise.

XDG Desktop Portal handles a lot of stuff for your desktop, like file pickers, screensharing, etc.

MUST READ - https://wiki.hyprland.org/Useful-Utilities/xdg-desktop-portal-hyprland/

## Authentication Agent

Starting method: manual (exec-once)

Authentication agents are the things that pop up a window asking you for a password whenever an app wants to elevate its privileges.

Our recommendation is the KDE one. For arch, it’s ```polkit-kde-agent```.

You can autostart it with ```exec-once=/usr/lib/polkit-kde-authentication-agent-1```. 

## Qt Wayland Support

Starting method: none (just a library)

Install ```qt5-wayland``` and ```qt6-wayland```.

# Status Bar - Waybar

https://wiki.hyprland.org/Useful-Utilities/Status-Bars/#waybar

Git Repo - https://github.com/Alexays/Waybar/wiki/Module:-Hyprland

# Wallpaper

https://wiki.hyprland.org/Useful-Utilities/Wallpapers/

# Screen Sharing

https://wiki.hyprland.org/Useful-Utilities/Screen-Sharing/

# App Launcher - Rofi (Wayland Fork)

Git Repo - https://github.com/lbonn/rofi

AUR - https://archlinux.org/packages/extra/x86_64/rofi-wayland/

# App Clients

    Discord
        WebCord 
        dissent

# Clipboard Managers - Cliphist

https://wiki.hyprland.org/Useful-Utilities/Clipboard-Managers/#cliphist

Git Repo - https://github.com/sentriz/cliphist

# Wireless Utilities

## Bluetooth
https://wiki.archlinux.org/title/Blueman

## Wifi
https://wiki.archlinux.org/title/NetworkManager

# hyprctl & sh scripts

