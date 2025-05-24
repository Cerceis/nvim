return {
{
  "Cerceis/mark-memo.nvim",
  config = function()
    require("mark-memo").setup({
      width = 15,
      height = 5,
      border = "rounded",
      position = "topright",
    })
  end
}
}
