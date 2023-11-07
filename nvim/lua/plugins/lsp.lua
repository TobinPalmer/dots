return {
  {
    "zeioth/garbage-day.nvim",
    event = "BufEnter",
    opts = {
      grace_period = 60 * 15,
      notifications = true,
    },
  },
}
