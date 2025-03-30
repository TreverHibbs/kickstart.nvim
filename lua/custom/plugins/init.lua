-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        multiline_threshold = 2,
      }
    end,
  },
  {
    'ThePrimeagen/harpoon',
    event = 'VimEnter',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      -- REQUIRED see install instructions for why
      -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
      harpoon.setup {
        --TODO setup harpoon to create lists of marks
        -- Setting up custom behavio for a list named "marks"
        -- "marks" = {
        --
        --   add = function(possible_value)
        --
        --   end,
        -- }
      }

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>oa', function()
        harpoon:list():add()
      end, { desc = 'Harp[O]on: [A]dd to list' })
      vim.keymap.set('n', '<leader>ol', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'harpoon show [L]ist' })

      vim.keymap.set('n', '<leader>o1', function()
        harpoon:list():select(1)
      end, { desc = 'select 1' })
      vim.keymap.set('n', '<leader>o2', function()
        harpoon:list():select(2)
      end, { desc = 'select 2' })
      vim.keymap.set('n', '<leader>o3', function()
        harpoon:list():select(3)
      end, { desc = 'select 3' })
      vim.keymap.set('n', '<leader>o4', function()
        harpoon:list():select(4)
      end, { desc = 'select 4' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>op', function()
        harpoon:list():prev()
      end, { desc = 'toggle next buffer' })
      vim.keymap.set('n', '<leader>on', function()
        harpoon:list():next()
      end, { desc = 'toggle previous buffer' })
    end,
  },
  {
    'jlcrochet/vim-razor',
  },
}
