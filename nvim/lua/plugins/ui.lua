return {
  {
    "karb94/neoscroll.nvim",
    init = function()
      require("neoscroll").setup()
    end,
    opts = {
      hide_cursor = false, -- Hide cursor while scrolling
      easing_function = "quadratic", -- Default easing function
    },
  },
}
