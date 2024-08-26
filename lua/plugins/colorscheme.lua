return {
	{ "Mofiqul/dracula.nvim" },
	-- { "sainnhe/gruvbox-material" },
	-- { "ellisonleao/gruvbox.nvim" },
	-- { "rose-pine/neovim", name = "rose-pine" },
	{ "scottmckendry/cyberdream.nvim" },
	-- { "sainnhe/sonokai" },
	-- { "tanvirtin/monokai.nvim" },
	-- { "shaunsingh/solarized.nvim" },
	-- { "sainnhe/edge" },
	{ "catppuccin/nvim", name = "catppuccin" },
	-- { "ribru17/bamboo.nvim" },
	{ "rebelot/kanagawa.nvim" },
	-- { "AlexvZyl/nordic.nvim" },
	-- { "ray-x/aurora" },
	-- { "EdenEast/nightfox.nvim" },
	-- { "miikanissi/modus-themes.nvim" },
	-- { "tiagovla/tokyodark.nvim" },
	-- { "folke/tokyonight.nvim" },
	-- {
	-- "0xstepit/flow.nvim",
	-- config = function()
	-- require("flow").setup({
	-- mode = "desaturate",
	-- })
	-- end,
	-- },
	-- { "neanias/everforest-nvim" },
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
	-- { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	-- { "rmehri01/onenord.nvim" },
	-- { "eldritch-theme/eldritch.nvim", lazy = false, priority = 1000 },
	-- { "zootedb0t/citruszest.nvim", lazy = false, priority = 1000 },
	-- { "Yazeed1s/minimal.nvim" },
	{ "uloco/bluloco.nvim", dependencies = { "rktjmp/lush.nvim" }, lazy = false, priority = 1000 },
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "deep",
			})
		end,
	},
}
