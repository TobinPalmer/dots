--- @class vscode
--- @field explorerVisible boolean
--- @field problemsOpen boolean
vim.g.vscode = {
	explorerVisible = false,
	problemsOpen = false,
}

local function resetView()
	print("RESETTING VIEW")
	vim.cmd([[call VSCodeCall("workbench.action.closeSidebar")]])
	vim.cmd([[call VSCodeCall("workbench.action.closeAuxiliaryBar")]])
	vim.cmd([[call VSCodeCall("workbench.action.closePanel")]])
end

vim.defer_fn(resetView, 500)

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>tt", function()
	print("Hello world")
end)

-- vim.keymap.set("n", "<leader>pv", function()
-- 	if not vim.g.vscode.explorerVisible then
-- 		vim.cmd([[call VSCodeCall('workbench.view.explorer')]])
-- 	else
-- 		vim.cmd([[call VSCodeCall('workbench.action.closeSidebar')]])
-- 	end
-- 	vim.g.vscode.explorerVisible = not vim.g.vscode.explorerVisible
-- end)

vim.keymap.set("n", "Q", "<nop>")

vim.api.nvim_create_user_command("CloseExplorer", function()
	vim.g.vscode.explorerVisible = false
end, {})
