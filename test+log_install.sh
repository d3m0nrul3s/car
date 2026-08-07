#!/bin/bash

### Данный скрипт еще не тестировался!!!!

# Файл, куда будут записываться все технические подробности и ошибки
LOG_FILE="$(pwd)/install_log.txt"

# Очищаем или создаем файл лога перед началом работы
echo "=== Лог установки от $(date) ===" > "$LOG_FILE"

# Функция для проверки выполнения шагов с логированием
run_step() {
  local msg="$1"
  shift

  # Выводим на экран только красивый статус
  echo -n "[⏳] $msg... "

  # Записываем заголовок шага в лог-файл
  echo -e "\n--- НАЧАЛО ШАГА: $msg ---" >> "$LOG_FILE"

  # Выполняем команду, перенаправляя stdout и stderr в файл лога
  "$@" >> "$FILE_LOG" 2>&1

  local status=$?
  if [ $status -ne 0 ]; then
    # Если ошибка, выводим статус на экран и пишем в лог
    echo -e "\r[🛑] ОШИБКА: $msg"
    echo -e "\n[КРИТИЧЕСКАЯ ОШИБКА] Команда завершилась с кодом $status" >> "$LOG_FILE"
    echo -e "--------------------------------------------------------" >> "$LOG_FILE"
    echo -e "\n❌ Установка прервана. Подробности ошибки смотри в файле:\n👉 $LOG_FILE\n"
    exit $status
  fi

  # Если всё успешно, обновляем статус на экране
  echo -e "\r[✅] $msg - Успешно"
  echo -e "--- КОНЕЦ ШАГА: УСПЕХ ---\n" >> "$LOG_FILE"
}

function check(){
  read -p '
  -----------
  1) Arch
  -----------
  2) Debian
  -----------
  -> ' name

  case "$name" in
    1)
      run_step "Обновление баз данных Arch" sudo pacman -Sy
      run_step "Установка основного софта Arch" sudo pacman -S --noconfirm i3-wm polybar obsidian lsd feh bat caja zathura fish picom python zsh slim btop zip unzip wget curl xclip rofi alacritty net-tools mpv flameshot ranger telegram-desktop kitty chromium firefox figlet base base-devel
      run_step "Скачивание скрипта BlackArch" curl -O https://blackarch.org
      ;;

    2)
      run_step "Обновление репозиториев Debian" sudo apt update
      run_step "Установка первой группы пакетов Debian" sudo apt-get install -y arandr curl zsh flameshot arc-theme feh i3blocks i3status i3 i3-wm lxappearance python3-pip rofi unclutter cargo compton papirus-icon-theme imagemagick
      run_step "Установка зависимостей сборки Debian" sudo apt-get install -y libxcb-shape0-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev autoconf meson
      run_step "Установка дополнительных утилит Debian" sudo apt-get install -y libxcb-render-util0-dev libxcb-shape0-dev libxcb-xfixes0-dev i3lock-fancy polybar kitty

      run_step "Обновление кэша шрифтов" fc-cache -fv

      run_step "Скачивание Alacritty DEB" wget -c https://github.com
      run_step "Установка Alacritty" sudo dpkg -i alacritty_0.10.0-rc4-1_amd64_bullseye.deb
      run_step "Исправление сломанных зависимостей" sudo apt install -f -y

      run_step "Клонирование i3-gaps" git clone https://github.com i3-gaps

      # Сборка i3-gaps
      cd i3-gaps || exit 1
      run_step "Конфигурация сборки i3-gaps (meson)" meson setup build --prefix=/usr
      run_step "Компиляция i3-gaps (ninja)" ninja -C build
      run_step "Установка i3-gaps" sudo ninja -C build install
      cd ../ || exit 1

      run_step "Установка pywal" pip3 install --break-system-packages pywal
      ;;

    *)
      echo "Неверный выбор. Пожалуйста, выберите 1 или 2."
      check
      ;;
  esac
}

# Запуск меню выбора ОС
check

# --- Пост-инсталляционный блок (шрифты и конфиги) ---

run_step "Создание директорий для шрифтов" mkdir -p ~/.local/share/fonts/ ~/.fonts ~/.config

run_step "Скачивание шрифта Iosevka" wget -c https://github.com
run_step "Скачивание шрифта RobotoMono" wget -c https://github.com
run_step "Скачивание шрифта Hack" wget -c https://github.com

run_step "Распаковка Iosevka" unzip -o Iosevka.zip -d ~/.local/share/fonts/
run_step "Распаковка RobotoMono" unzip -o RobotoMono.zip -d ~/.local/share/fonts/
run_step "Распаковка Hack" unzip -o Hack.zip -d ~/.fonts/

run_step "Копирование конфигурационных файлов" cp -rv config/* ~/.config/
run_step "Копирование seclist" cp -rv seclist ~/
run_step "Копирование бинарников" cp -rv bin ~/
run_step "Копирование обоев и fehbg" sh -c "cp fehbg ~/.fehbg && cp -rv images ~/.images"

run_step "Установка прав на выполнение для скриптов" sh -c "chmod +x ~/bin/* ~/.config/bin/* ~/.config/polybar/launch.sh"

run_step "Запуск дополнительных скриптов" bash additional_files.sh

run_step "Установка Oh My Zsh" sh -c "$(curl -fsSL https://githubusercontent.com) --unattended"

echo -e "\n🎉 [ПОЗДРАВЛЯЕМ] Скрипт успешно дошел до конца! Полный лог сохранен в: $LOG_FILE"
