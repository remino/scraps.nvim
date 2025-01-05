local M = {}

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

if not vim.g.scraps_dir then
	vim.g.scraps_dir = vim.fn.expand((os.getenv("XDG_DATA_HOME") or "~/.local/share") .. "/scraps")
end

local function is_table_empty(t)
	return next(t) == nil
end

if not vim.g.scraps_dirs or is_table_empty(vim.g.scraps_dirs) then
	vim.g.scraps_dirs = { vim.g.scraps_dir }
end

local function require_telescope()
	local status, _ = pcall(require, "telescope")
	if not status then
		vim.notify("Telescope is required for Scraps", vim.log.levels.ERROR, { title = "Scraps Error" })
		return
	end
end

local function split_string(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function ternary(cond, T, F)
	if cond then
		return T
	else
		return F
	end
end

local function browse(user_dirs)
	require_telescope()

	local dirs = user_dirs or vim.fn.expand("%:p:h")

	-- prompt title should only be the name of all dirs
	local prompt_title = ""
	for _, dir in ipairs(dirs) do
		if not prompt_title == "" then
			prompt_title = vim.fn.fnamemodify(dir, ":t") .. " "
		else
			prompt_title = prompt_title .. vim.fn.fnamemodify(dir, ":t")
		end
	end

	require("telescope.builtin").find_files({
		prompt_title = prompt_title,
		cwd = dirs[1],
		search_dirs = dirs,
		follow = true,
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

vim.api.nvim_create_user_command("Scraps", function(options)
	local dirs = split_string(options.args, ":")

	if is_table_empty(dirs) then
		browse(ternary(is_table_empty(vim.g.scraps_dirs), vim.fn.expand("%:p:h"), vim.g.scraps_dirs))
		return
	end

	browse(dirs)
end, {
	desc = "Browse scraps directory",
	nargs = "?",
	complete = "dir",
})

vim.api.nvim_create_user_command("ScrapsConfigDir", function()
	browse({ vim.fn.expand((os.getenv("XDG_CONFIG_HOME") or "~/.config") .. "/nvim") })
end, {
	desc = "Browse the Neovim configuration directory",
})

vim.api.nvim_create_user_command("ScrapsCurrentDir", function()
	browse({ vim.fn.expand("%:p:h") })
end, {
	desc = "Browse the current directory",
})

function M.setup(opts)
	opts = opts or {}

	if opts.scraps_dir then
		vim.notify(
			"The scraps_dir option is deprecated. Please use scraps_dirs instead.",
			vim.log.levels.WARN,
			{ title = "Scraps Warning" }
		)
		vim.g.scraps_dir = opts.scraps_dir or vim.g.scraps_dir
		vim.g.scraps_dirs = { vim.g.scraps_dir }
	end

	if opts.scraps_dirs then
		vim.g.scraps_dirs = opts.scraps_dirs
		vim.g.scraps_dir = opts.scraps_dirs[1]
	end
end

return M
