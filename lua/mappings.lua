require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage git hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>fs", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "telescope find workspace symbols" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "telescope find references" })
map("n", "<leader>fl", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "telescope find local buffer symbols" })

map("n", "g<leader>d", function()
  -- Сохраняем исходное окно
  local original_win = vim.api.nvim_get_current_win()
  local original_buf = vim.api.nvim_get_current_buf()

  -- Проверяем LSP в текущем буфере
  local clients = vim.lsp.get_active_clients({ bufnr = original_buf })
  if #clients == 0 then
    print("❌ No LSP in current buffer")
    return
  end

  local client = clients[1]

  -- Показываем окна
  local windows = {}
  for i = 1, vim.fn.winnr("$") do
    local win_id = vim.fn.win_getid(i)
    local buf = vim.api.nvim_win_get_buf(win_id)
    local name = vim.api.nvim_buf_get_name(buf)
    local short = vim.fn.fnamemodify(name, ":t")
    windows[i] = { win_id = win_id, buf = buf, name = short }
    print(string.format("%d: %s (buf: %d)", i, short ~= "" and short or "[No Name]", buf))
  end

  -- Асинхронный выбор
  vim.ui.input({
    prompt = "Window number: ",
    default = ""
  }, function(input)
    if not input then return end
    local num = tonumber(input)
    if not num or num < 1 or num > #windows then
      print("❌ Invalid window")
      return
    end

    -- ВАЖНО: Сохраняем оригинальное окно ДО запроса
    local saved_win = original_win

    -- Выполняем LSP запрос с кастомным обработчиком
    local params = vim.lsp.util.make_position_params()

    client.request("textDocument/definition", params, function(err, result)
      if err or not result or not result[1] then
        print("No definition found")
        return
      end

      -- Открываем в выбранном окне
      local target_win = windows[num].win_id
      local current_win = vim.api.nvim_get_current_win()

      -- Если мы не в нужном окне, переключаемся
      if current_win ~= target_win then
        vim.api.nvim_set_current_win(target_win)
      end

      -- Открываем результат
      vim.lsp.util.jump_to_location(result[1], client.offset_encoding)

      -- Возвращаем фокус в исходное окно (если нужно)
      vim.api.nvim_set_current_win(saved_win)
    end)
  end)
end, { desc = "Select window for LSP result" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
