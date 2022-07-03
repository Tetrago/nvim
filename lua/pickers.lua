local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')

local M = {}

M.install_syntax = function(opts)
	opts = opts or {}

	pickers.new(opts, {
		prompt_title = 'Install Syntax',
		finder = finders.new_table({ results = require('nvim-treesitter.parsers').available_parsers() }),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()

				vim.cmd('TSInstall ' .. selection[1])
			end)

			return true
		end
	}):find()
end

return M
