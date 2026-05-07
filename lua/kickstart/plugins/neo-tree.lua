-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          -- Map 'tf' to Telescope find_files in the current directory
          ['tf'] = 'telescope_find',
          -- Map 'tg' to Telescope live_grep in the current directory
          ['tg'] = 'telescope_grep',
        },
      },
      commands = {
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node.type == 'directory' and node:get_id() or vim.fn.fnamemodify(node:get_id(), ':h')
          require('telescope.builtin').find_files {
            cwd = path,
          }
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node.type == 'directory' and node:get_id() or vim.fn.fnamemodify(node:get_id(), ':h')
          require('telescope.builtin').live_grep {
            cwd = path,
          }
        end,
      },
    },
  },
}
