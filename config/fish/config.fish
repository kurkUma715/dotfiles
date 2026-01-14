set -U fish_greeting

if status is-interactive
    # Устанавливаем функцию промпта
    function fish_prompt
        # Цвета
        set normal (set_color normal)
        set cyan (set_color cyan)
        set red (set_color red)
        set green (set_color green)
        set yellow (set_color yellow)
        set magenta (set_color magenta)

        # Часть с путем
        echo -n -s $cyan (prompt_pwd) " "

        # Часть с пользователем (только для root)
        if test (id -u) -eq 0
            echo -n -s $red "#"
        end

        # Часть с git
        set git_info ""
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set git_branch (git branch --show-current 2>/dev/null)
            if test -n "$git_branch"
                set git_info "($git_branch)"
            end
        end

        # Завершающий символ
        echo -n -s $normal $magenta $git_info "❯"

    end
end
