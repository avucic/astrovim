return {
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>og"] = { ":Gen<CR>", desc = "Ollama" }
          maps.n["<Leader>oG"] = { "<cmd>lua require('gen').select_model()<cr>", desc = "Change Ollama model" }
        end,
      },
    },
    opts = function(_, opts)
      opts.model = "mistral" -- The default model to use.
      opts.display_mode = "float" -- The display mode. Can be "float" or "split".
      opts.show_prompt = true -- Shows the Prompt submitted to Ollama.
      opts.show_model = true -- Displays which model you are using at the beginning of your chat session.
      opts.no_auto_close = false -- Never closes the window automatically.

      opts.init = function(options) pcall(io.popen "ollama serve > /dev/null 2>&1 &") end
      -- Function to initialize Ollama
      opts.command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body"
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = "<omitted lua function>", -- Retrieves a list of model names
      opts.debug = false -- Prints errors and the command which is run.
    end,
  },
}
