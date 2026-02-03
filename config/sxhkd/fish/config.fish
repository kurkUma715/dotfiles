# ~/.config/fish/config.fish
# Отключаем приветственное сообщение
set -U fish_greeting ""

if status is-interactive
    function fish_prompt
        # Цвета
        set -l normal (set_color normal)
        set -l green (set_color green)
        set -l white (set_color white)
        set -l red (set_color red)
        set -l yellow (set_color yellow)
        
        # 1. ЗЕЛЁНЫЙ ПУТЬ
        echo -n -s $green (prompt_pwd) " "
        
        # 2. СИМВОЛ ПРИВИЛЕГИЙ (белый $ / красный #)
        if test (id -u) -eq 0
            # ROOT - красный #
            echo -n -s $red "#"
        else
            # обычный пользователь - белый $
            echo -n -s $white "\$"
        end
        
        # 3. БЕЛАЯ СТРОКА ВВОДА
        echo -n -s $normal " "
    end
    
    # Опционально: правая часть промпта для Git информации
    function fish_right_prompt
        # Добавляем информацию о Git только если есть
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set -l git_branch (git branch --show-current 2>/dev/null)
            if test -n "$git_branch"
                set -l yellow (set_color yellow)
                set -l normal (set_color normal)
                echo -n -s $yellow "(" $git_branch ")" $normal
            end
        end
    end
end
