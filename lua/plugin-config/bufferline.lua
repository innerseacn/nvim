  require "bufferline".setup {
    options = {
      always_show_bufferline = false,
      modified_icon = '✥',
      buffer_close_icon= "",
      close_icon = "",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      show_tab_indicators = true,
      -- view = "multiwindow" | "default",
      numbers = "ordinal",
      number_style = {"", ""}, -- buffer_id at index 1, ordinal at index 2
      -- mappings = true | false,
      -- left_trunc_marker = "",
      -- right_trunc_marker = "",
      -- max_name_length = 18,
      -- max_prefix_length = 15, -- prefix used when a buffer is deduplicated
      -- tab_size = 18,
      -- show_buffer_icons = true | false,
      show_buffer_close_icons = false,
      -- show_close_icon = true | false,
      -- persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- -- can also be a table containing 2 custom separators
      -- -- [focused and unfocused]. eg: { "|", "|" }
      -- separator_style = "slant" | "padded_slant" | "thick" | "thin" | { "any", "any" },
      -- enforce_regular_tabs = false | true,
      -- always_show_bufferline = true | false,
      -- offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center" | "right" | "left"}},
      -- sort_by = "id" | "extension" | "relative_directory" | "directory" | "tabs" | function(buffer_a, buffer_b)
      -- -- add custom logic
      --     return buffer_a.modified > buffer_b.modified
      -- end
    }
  }
