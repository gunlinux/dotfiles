return {
  "leoluz/nvim-dap-go",
  lazy = true,
  ft = "go",
  config = function()
    local dap = require("dap")

    -- Конфигурация отладчика для Go
    dap.adapters.go = function(callback, config)
      callback({
        type = "server",
        host = "127.0.0.1",
        port = 38697  -- Укажи стандартный порт Delve
      })
    end

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}", -- Запуск текущего файла
      },
    }

    -- Настройка для nvim-dap-go
    require("dap-go").setup({
      delve = {
        initialize_timeout_sec = 20,  -- Таймаут инициализации Delve
        port = 38697,  -- Укажи тот же порт
      }
    })
  end,
}

