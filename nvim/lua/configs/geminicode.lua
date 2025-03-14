M = {}

M.config = function()
  require("gemini").setup {
    model_config = {
      model_id = "gemini-2.0-flash-thinking-exp-01-21",
    },
  }
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
