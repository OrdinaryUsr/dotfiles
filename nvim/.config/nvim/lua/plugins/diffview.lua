-- Review commits and branches: file tree on the left, side-by-side diff on the right.
--
-- Inside the view:
--   <Tab> / <S-Tab>  next / previous file
--   ]c / [c          next / previous change in the file
--   <leader>e        focus the file panel, <leader>b toggles it
--   g?               list all mappings of the current panel
return {
  'sindrets/diffview.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff: uncommitted changes' },
    { '<leader>gl', '<cmd>DiffviewOpen HEAD^!<cr>', desc = '[G]it diff: [L]ast commit' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it [H]istory of current file' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it [H]istory of the repo' },
    { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = '[G]it diff: [Q]uit view' },
  },
  opts = {
    use_icons = vim.g.have_nerd_font,
    enhanced_diff_hl = true, -- softer highlight for changed lines, stronger for changed words
    view = {
      default = { layout = 'diff2_horizontal' },
      file_history = { layout = 'diff2_horizontal' },
    },
    file_panel = {
      listing_style = 'tree',
      win_config = { position = 'left', width = 40 },
    },
  },
}
