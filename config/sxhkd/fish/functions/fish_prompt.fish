function fish_prompt
    set cyan (set_color cyan)
    set red (set_color red)
    set magenta (set_color magenta)
    set normal (set_color normal)

    # Текущая директория
    echo -n -s $cyan (prompt_pwd) " "

    # Проверка git репозитория
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set git_branch (git branch --show-current 2>/dev/null)
        if test -n "$git_branch"
            echo -n -s $magenta "($git_branch) "
        end
    end

    # Символ приглашения
    if test (id -u) -eq 0
        echo -n -s $red "#>"
    else
        echo -n -s $normal ">"
    end

    echo -n -s $normal " "
end
