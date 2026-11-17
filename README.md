# dotfiles

Конфиги, управляемые через [GNU Stow](https://www.gnu.org/software/stow/). Каждый каталог верхнего уровня — пакет, структура внутри повторяет `$HOME`.

| Пакет      | Куда попадает                                        |
|------------|------------------------------------------------------|
| `nvim`     | `~/.config/nvim`                                     |
| `tmux`     | `~/.config/tmux`                                     |
| `kitty`    | `~/.config/kitty`                                    |
| `ghostty`  | `~/.config/ghostty`                                  |
| `zsh`      | `~/.config/zsh` (нужен `ZDOTDIR`, см. ниже)          |
| `opencode` | `~/.config/opencode`                                 |
| `claude`   | отдельные файлы и каталоги внутри `~/.claude`        |

## Установка на новой машине

```sh
brew install stow
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow nvim tmux kitty ghostty zsh opencode claude
```

Репозиторий должен лежать в `~/dotfiles`: stow по умолчанию создаёт симлинки в родительском каталоге.

Дополнительно:

- **zsh**: в `~/.zprofile` должна быть строка `export ZDOTDIR="$HOME/.config/zsh"`.
  Секреты и машинно-зависимые переменные кладутся в `~/.config/zsh/.zshrc.local` (не отслеживается).
- **tmux**: плагины ставятся через `~/.config/tmux/install.sh`.
- **opencode**: `bun install` в `~/.config/opencode`.

## Повседневная работа

```sh
stow <пакет>       # создать симлинки
stow -D <пакет>    # убрать симлинки
stow -R <пакет>    # пересоздать (после добавления или удаления файлов)
stow -n -v <пакет> # показать, что будет сделано, ничего не меняя
```

Новый файл в `~/.claude` добавляется так: переместить его в `claude/.claude/` и выполнить `stow -R claude`.
