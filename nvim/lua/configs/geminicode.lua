M = {}

M.config = function()
  require("gemini").setup {}
end

M.keys = {
  {
    "<leader>gr",
    "<cmd>GeminiCodeReview<cr>",
    desc = "Gemini Code Review",
  },
  {
    "<leader>ge",
    "<cmd>GeminiCodeExplain<cr>",
    desc = "Gemini Code Explain",
  },
  {
    "<leader>gt",
    "<cmd>GeminiUnitTest<ct>",
    desc = "Gemini Unit Test",
  },
  {
    "<leader>gc",
    ":GeminiChat ",
    desc = "Gemini Chat",
  },
}

return M
