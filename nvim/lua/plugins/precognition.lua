return {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
    },
    keys = {
      {
        "<leader>p",
        function ()
         require("precognition").toggle()
        end,
        desc = "precognition",
      },
    },


  }
