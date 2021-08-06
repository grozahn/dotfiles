local lspconfig = require('lspconfig')
local lsp = vim.lsp
local g = vim.g
local cmd = vim.cmd


-- Utility to restart specific client
lsp.restart_client = function(client_name)
  local clients = lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == client_name then
      local bufs = lsp.get_buffers_by_client_id(client.id)

      lsp.stop_client(client.id)
      local client_id = lsp.start_client(client.config)

      -- Reattach client to existing buffers
      for _, bufnr in ipairs(bufs) do
        lsp.buf_attach_client(bufnr, client_id)
      end
    end
  end
end

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

-- Setup order of completitions --
g.completion_chain_complete_list = {
  { complete_items = { 'lsp', 'snippet', 'buffers', 'path' } },
  { mode = '<C-k>' },
  { mode = '<C-j>' }
}

g.completion_matching_ignore_case = true
g.completion_confirm_key = '<C-y>'

g.completion_items_priority = {
  Field = 10,
  Function = 9,
  Method = 8,
  Module = 7,
  Variables = 7,
  Interfaces = 5,
  Constant = 6,
  Class = 5,
  Keyword = 4,
  Buffers = 1,
  TabNine = 0,
  File = 0
}

local map = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, { noremap = true, silent = true });
end

local on_attach = function(client)
  require('completion').on_attach(client, {
      enable_auto_popup = 1,
      enable_auto_signature = 1,
      auto_change_source = 1,
      enable_auto_hover = 1,
    })

  -- Mappings.
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'L', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  map('n', ']e', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  map('n', '[e', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
  map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', '<leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', '<leader>lf', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
  map('n', '<leader>lF', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>')
  map('n', '<leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', '<leader>ls', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>')
end

local servers = {
  -- Python
  pyright = {},

  -- Golang
  gopls = {},

  -- Rust
  rust_analyzer = {},

  -- C/C++
  clangd = {}
}

-- Setup servers
for srv, conf in pairs(servers) do
  conf.on_attach    = on_attach
  conf.flags        = { debounce_text_changes = 150 }

  lspconfig[srv].setup(conf)
end
