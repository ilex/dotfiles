from libqtile.config import Screen, Key
from libqtile import bar, widget
from libqtile.command import lazy


def change_keyboard_layout():
    def callback(qtile):
        qtile.widgetMap.get('KeyboardLayout').next_keyboard()

    return callback


mod = 'mod4'
alt = 'mod1'

keys = [
    Key([mod], 'Return', lazy.spawn('gnome-terminal --hide-menubar')),
    Key([mod], 'b', lazy.spawn('google-chrome')),
    # Toggle between different layouts as defined below
    # Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    # Switch between windows in current stack pane
    Key([alt], 'Tab', lazy.layout.down()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
    Key([], 'Caps_Lock', lazy.function(change_keyboard_layout())),
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 1 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 1 -q set Master 2dB-")
    ),
]

screens = [
    Screen(
        top=bar.Bar([
            widget.GroupBox(),
            widget.WindowName(),
            widget.TextBox('🔋'),
            widget.Battery(battery_name='BAT1'),
            widget.TextBox('🔈'),
            widget.Volume(cardid=1, device=None, update_interval=0.2),
            widget.Systray(icon_size=14),
            widget.KeyboardLayout(
                name='KeyboardLayout',
                configured_keyboards=['us', 'ru', 'ua']
            ),
            widget.Clock(
                format='%Y-%m-%d %H:%M',
            ),
        ], 30),
    ),
    Screen(
        top=bar.Bar([
            widget.GroupBox(),
            widget.WindowName()
            ], 30),
    )
]
