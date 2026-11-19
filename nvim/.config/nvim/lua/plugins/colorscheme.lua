return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'Mofiqul/dracula.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    -- Let the terminal background (and its opacity) show through.
    transparent_bg = true,
    -- Code highlighting follows tokyonight's layout, in Dracula colours.
    overrides = function(colors)
      return require('custom.dracula_syntax').overrides(colors)
    end,
  },
  config = function(_, opts)
    require('dracula').setup(opts)

    -- Load the colorscheme here ('dracula' or 'dracula-soft').
    vim.cmd.colorscheme 'dracula'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
