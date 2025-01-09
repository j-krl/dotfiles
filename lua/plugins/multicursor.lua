return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")

		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		set({ "n", "v" }, "<leader>ck", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add cursor above" })
		set({ "n", "v" }, "<leader>cj", function()
			mc.lineAddCursor(1)
		end, { desc = "Add cursor below" })
		set({ "n", "v" }, "<leader><up>", function()
			mc.lineSkipCursor(-1)
		end, { desc = "Skip cursor above" })
		set({ "n", "v" }, "<leader><down>", function()
			mc.lineSkipCursor(1)
		end, { desc = "Skip cursor below" })

		-- Add or skip adding a new cursor by matching word/selection
		set({ "n", "v" }, "<leader>cn", function()
			mc.matchAddCursor(1)
		end, { desc = "Add cursor by match below" })
		set({ "n", "v" }, "<leader>c;", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip cursor by match below" })
		set({ "n", "v" }, "<leader>cp", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add cursor by match above" })
		set({ "n", "v" }, "<leader>c,", function()
			mc.matchSkipCursor(-1)
		end, { desc = "Skip cursor by match above" })

		-- Add all matches in the document
		set({ "n", "v" }, "<leader>cA", mc.matchAllAddCursors, { desc = "Add cursor add all matches" })

		-- Custom horizontal motions
		set("n", "<leader><right>", function()
			mc.skipCursor("l")
		end, { desc = "Skip cursor right" })
		set("n", "<leader><left>", function()
			mc.skipCursor("h")
		end, { desc = "Skip cursor left" })
		-- set("n", "<leader>cw", function()
		-- 	mc.addCursor("w")
		-- end, { desc = "Add cursor next word" })
		-- set("n", "<leader>cW", function()
		-- 	mc.skipCursor("w")
		-- end, { desc = "Skip cursor next word" })
		-- set("n", "<leader>cb", function()
		-- 	mc.addCursor("b")
		-- end, { desc = "Add cursor prev word" })
		-- set("n", "<leader>cB", function()
		-- 	mc.skipCursor("b")
		-- end, { desc = "Skip cursor prev word" })
		-- set("n", "<leader>ce", function()
		-- 	mc.addCursor("e")
		-- end, { desc = "Add cursor end of next word" })
		-- set("n", "<leader>cE", function()
		-- 	mc.skipCursor("e")
		-- end, { desc = "Skip cursor end of next word" })
		-- set("n", "<leader>c^", function()
		-- 	mc.addCursor("^")
		-- end, { desc = "Add cursor start of line (non ws)" })
		-- set("n", "<leader>c$", function()
		-- 	mc.addCursor("$")
		-- end, { desc = "Add cursor end of line" })

		-- Rotate the main cursor.
		set({ "n", "v" }, "<leader>cr", mc.nextCursor, { desc = "Rotate cursor next" })
		set({ "n", "v" }, "<leader>cR", mc.prevCursor, { desc = "Rotate cursor prev" })

		-- Delete the main cursor.
		set({ "n", "v" }, "<leader>cd", mc.deleteCursor, { desc = "Delete cursor" })

		-- Add and remove cursors with control + right click.
		set("n", "<c-rightmouse>", mc.handleMouse, { desc = "Add cursor on click" })

		-- Easy way to add and remove cursors using the main cursor.
		set({ "n", "v" }, "<leader>ct", mc.toggleCursor, { desc = "Add cursor under main cursor" })

		-- Clone every cursor and disable the originals.
		set({ "n", "v" }, "<leader>cy", mc.duplicateCursors, { desc = "Duplicate cursors" })
		set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc> handler.
			end
		end)

		-- bring back cursors if you accidentally clear them
		set("n", "<leader>cu", mc.restoreCursors, { desc = "Restore cursors" })

		-- Align cursor columns.
		set("n", "<leader>ca", mc.alignCursors, { desc = "Align cursor columns" })

		-- Split visual selections by regex.
		set("v", "<leader>cS", mc.splitCursors, { desc = "Split visual selections by regex" })

		-- Append/insert for each line of visual selections.
		set("v", "I", mc.insertVisual, { desc = "Prepend at each line of visual selection" })
		set("v", "A", mc.appendVisual, { desc = "Append each line of visual selection" })

		-- match new cursors within visual selections by regex.
		set("v", "<leader>cM", mc.matchCursors, { desc = "Match within visual selections" })

		-- Rotate visual selection contents.
		set("v", "<leader>cr", function()
			mc.transposeCursors(1)
		end, { desc = "Rotate visual selection forward" })
		set("v", "<leader>cR", function()
			mc.transposeCursors(-1)
		end, { desc = "Rotate visual selection backward" })

		-- Jumplist support (they don't work?)
		-- set({ "v", "n" }, "<c-i>", mc.jumpForward)
		-- set({ "v", "n" }, "<c-o>", mc.jumpBackward)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
