#!/bin/sh

ip_target=$(cat ~/.config/bin/target | awk '{print $1}')
name_target=$(cat ~/.config/bin/target | awk '{print $2}')

# --- ДОБАВЛЕННЫЙ БЛОК ДЛЯ КОПИРОВАНИЯ ---
# Если скрипт вызван с аргументом "copy", копируем только IP и завершаем работу
if [ "$1" = "copy" ]; then
    if [ -n "$ip_target" ]; then
        # Для X11 (i3wm, bspwm):
        echo -n "$ip_target" | xclip -selection clipboard

        # Если вы используете Wayland (Sway, Hyprland), раскомментируйте строку ниже, а верхнюю закомментируйте:
        # echo -n "$ip_target" | wl-copy
    fi
    exit 0
fi

if [ $ip_target ] && [ $name_target ]; then
    echo "%{F#cf9fff}什%{F#ffffff} $ip_target - $name_target"
elif [ $(cat ~/.config/bin/target | wc -w) -eq 1 ]; then
    echo "%{F#cf9fff}什%{F#ffffff} $ip_target"
else
    echo "%{F#cf9fff}ﲅ %{u-}%{F#ffffff} No target"
fi

# target "ip carname"
