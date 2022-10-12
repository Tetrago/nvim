local scan = require('plenary.scandir')
local Path = require('plenary.path')

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')


local M = {}
M.templates_dir = vim.fn.stdpath('config') .. '/templates'

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

function find_templates()
	local files = scan.scan_dir(M.templates_dir, { hidden = false })

	for i, v in ipairs(files) do
		files[i] = Path:new(v):make_relative(M.templates_dir)
	end

	return files
end

M.template = function(opts)
	opts = opts or {}

	pickers.new(opts, {
		prompt_title = 'Template',
		finder = finders.new_table({ results = find_templates() }),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()

				vim.cmd('read ' .. M.templates_dir .. '/' .. selection[1])
			end)

			return true
		end
	}):find()
end

return M
