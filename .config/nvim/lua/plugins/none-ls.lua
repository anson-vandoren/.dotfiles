return {
  "nvimtools/none-ls.nvim",
  optional = true,
  opts = function(_, opts)
    if vim.fn.executable("credo") == 0 then
      return
    end
    local nls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.diagnostics.credo,
    })
  end,
}
