local M = {}

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.g.scraps_dir = vim.fn.expand((os.getenv("XDG_DATA_HOME") or "~/.local/share") .. "/scraps")

local function browse(dir)
	local directory = dir or vim.fn.expand("%:p:h")

	require("telescope.builtin").find_files({
		prompt_title = directory,
		cwd = directory,
		previewer = true,
		attach_mappings = function(_, map)
			map("i", "<C-p>", function(prompt_bufnr)
				local entry = action_state.get_selected_entry()
				local file_path = entry.path
				actions.close(prompt_bufnr)
				vim.api.nvim_command("read " .. file_path)
			end)
			return true
		end,
	})
end

function M.setup(opts)
	opts = opts or {}
	vim.g.scraps_dir = opts.scraps_dir or vim.g.scraps_dir

	local status, _ = pcall(require, "telescope")
	if not status then
		vim.notify("Telescope is required for Scraps", vim.log.levels.ERROR, { title = "Scraps Error" })
		return
	end

	vim.api.nvim_create_user_command("Scraps", function(options)
		browse(options.args or vim.g.scraps_dir or vim.fn.expand("%:p:h"))
	end, {
		desc = "Browse scraps directory",
		nargs = "?",
		complete = "dir",
	})

	vim.api.nvim_create_user_command("ScrapsConfigDir", function()
		browse(vim.fn.expand((os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/nvim"))
	end, {
		desc = "Browse the Neovim configuration directory",
	})

	vim.api.nvim_create_user_command("ScrapsCurrentDir", function()
		browse(vim.fn.expand("%:p:h"))
	end, {
		desc = "Browse the current directory",
	})
end

return M
