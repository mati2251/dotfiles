return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go'
  },
  config = function()
    local dap = require('dap')
    local dapui = require("dapui")
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
    vim.keymap.set('n', '<Leader>dx', function() dap.terminate() end)
    vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
    -- languages specifics
    -- go
    require('dap-go').setup()
    -- haskell
    dap.adapters.haskell = {
      type = 'executable',
      command = 'haskell-debug-adapter',
      args = { '--hackage-version=0.0.33.0' },
    }


    dap.configurations.haskell = {
      {
        type = 'haskell',
        request = 'launch',
        name = 'Debug',
        workspace = '${workspaceFolder}',
        startup = "${file}",
        stopOnEntry = true,
        logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
        logLevel = 'WARNING',
        ghciEnv = vim.empty_dict(),
        ghciPrompt = "λ: ",
        ghciInitialPrompt = "λ: ",
        ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
      },
    }

    -- kotlin
    dap.adapters.kotlin = {
      type = "executable",
      command = "kotlin-debug-adapter",
      options = { auto_continue_if_many_stopped = false },
    }

    dap.configurations.kotlin = {
      {
        type = "kotlin",
        request = "launch",
        name = "This file",
        -- may differ, when in doubt, whatever your project structure may be,
        -- it has to correspond to the class file located at `build/classes/`
        -- and of course you have to build before you debug
        mainClass = function()
          local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
          local fname = vim.api.nvim_buf_get_name(0)
          -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
          return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
        end,
        projectRoot = "${workspaceFolder}",
        jsonLogFile = "",
        enableJsonLogging = false,
      },
      {
        -- Use this for unit tests
        -- First, run
        -- ./gradlew --info cleanTest test --debug-jvm
        -- then attach the debugger to it
        type = "kotlin",
        request = "attach",
        name = "Attach to debugging session",
        port = 5005,
        args = {},
        projectRoot = vim.fn.getcwd,
        hostName = "localhost",
        timeout = 2000,
      },

    }

    -- c/cpp
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "-i", "dap" }
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
    }
  end,
}
