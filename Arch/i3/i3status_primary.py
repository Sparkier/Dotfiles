# -*- coding: utf-8 -*-
from i3pystatus import Status

status = Status()

status.register("clock",
                format="%a %-d %b %H:%M")

status.register("pulseaudio",
                format="♪ {volume}%",
                color_muted="#707070")

status.run()