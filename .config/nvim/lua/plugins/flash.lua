return {
  "folke/flash.nvim",
  keys = {
    -- disable the default flash keymap
    { "s", mode = { "n", "x", "o" }, false },
  },
  opts = {
    modes = {
      char = {
        keys = { "f", "F", "t", "T", [";"] = ":", "," },
      },
    },
  },
}
