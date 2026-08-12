return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go',
    'nvim-neotest/nvim-nio'
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
    require('dap-go').setup()
  end,
}
