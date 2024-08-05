require("config.lazy")

if vim.g.vscode then
    -- undo/REDO via vscode
    vim.keymap.set("n","u","<Cmd>call VSCodeNotify('undo')<CR>")
    vim.keymap.set("n","<C-r>","<Cmd>call VSCodeNotify('redo')<CR>") 
end
