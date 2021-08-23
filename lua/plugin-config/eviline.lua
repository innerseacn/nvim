local gl = require("galaxyline")
local colors = require('material.colors') ---- use material.nvim colorscheme ----
-- local colors = require('galaxyline.theme').default
local condition = require("galaxyline.condition")
local fileinfo = require('galaxyline.provider_fileinfo')
local vcmd = vim.api.nvim_command
local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "dbui", "packer", "help"}

---- TODO: more smart condition.hide_in_width() ----
---- TODO: make colors change when colorscheme executed ----
---- make colors compatible with material darker theme ----
colors.bg = colors.active
colors.violet = colors.purple
colors.magenta = colors.pink

---- auto change color according the vim mode ----
local mode_color = { n = colors.red, i = colors.green, v = colors.blue,
  [""] = colors.blue, V = colors.blue, c = colors.yellow, no = colors.red,
  s = colors.orange, S = colors.orange, [""] = colors.orange, ic = colors.yellow,
  R = colors.violet, Rv = colors.violet, cv = colors.red, ce = colors.red,
  r = colors.cyan, rm = colors.cyan, ["r?"] = colors.cyan, ["!"] = colors.red,
  t = colors.red
}

gls.left[1] = {
  Time = {
    provider = function()
      vcmd("hi GalaxyTime guifg=" .. mode_color[vim.fn.mode()])
      if os.date('%H') == '23' then
        vcmd("hi GalaxyTime gui=reverse,bold")
        vcmd("hi FileNameSeparator guibg=" .. mode_color[vim.fn.mode()])
      end
      return "▌  " .. os.date('[%H:%M]')
    end,
    separator = '',
    separator_highlight = 'FileNameSeparator',
    highlight = {"none", colors.bg, 'bold'}
  }
}

local modified_color = false ---- for modified color change ----
gls.left[2] = {
  FileName = {
    provider = function()
      local file = vim.fn.expand('%:~:.')
      if vim.fn.empty(file) == 1 then return '' end
      if vim.bo.readonly == true then
        return file .. " "
      end
      if vim.bo.modified then
        if not modified_color then
          vcmd("hi GalaxyFileName gui=reverse")
          vcmd("hi FileNameSeparator guifg=" .. fileinfo.get_file_icon_color())
          modified_color = true
        end
        return file .. ' '
      end
      if modified_color then
        vcmd("hi GalaxyFileName gui=none")
        vcmd("hi FileNameSeparator guifg=" .. colors.bg)
        modified_color = false
      end
      if string.len(file) > 50 then
        file = '…' .. string.sub(file,-50)
      end
      return file
    end,
    icon = fileinfo.get_file_icon,
    condition = condition.buffer_not_empty,
    separator = '',
    separator_highlight = {colors.bg, colors.bg},
    highlight = {fileinfo.get_file_icon_color, colors.bg}
  }
}

gls.left[3] = {
  LineInfo = {
    provider = 'FileSize',
    -- provider = function()
    --   local line = vim.fn.line('.')
    --   local totalline = vim.fn.line('$')
    --   local column = vim.fn.col('.')
    --   local percent = fileinfo.current_line_percent()
    --   return string.format("[%d/%d]:[%d]%s", line, totalline, column, percent)
    -- end,
    -- condition = condition.hide_in_width,
    -- separator = ">",
    -- separator_highlight = {"NONE", colors.bg},
    highlight = {colors.gray, colors.bg}
  }
}

-- 
--     
-- ░▒▓█
-- ⭘     

gls.left[4] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {colors.red, colors.bg}
  }
}
gls.left[5] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {colors.yellow, colors.bg}
  }
}

gls.left[6] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = {colors.cyan, colors.bg}
  }
}

gls.left[7] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    -- separator = ' ',
    -- separator_highlight = {colors.bg, 'none'},
    highlight = {colors.blue, colors.bg}
  }
}
--[[
gls.left[8] = {
  MidSpace = {
    provider = function()
      vcmd("hi GalaxyMidSpace guibg=" .. mode_color[vim.fn.mode()])
      return ""
    end,
  }
}
]]

local lsp = require('galaxyline.provider_lsp')
gls.mid[1] = {
  ShowLspClient = {
    provider = function()
      return lsp.get_lsp_client() .. ' '
    end,
    condition = function()
      local tbl = {["dashboard"] = true, [""] = true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return condition.hide_in_width()
    end,
    icon = "  LSP:",
    highlight = {colors.yellow, colors.bg}
  }
}

gls.right[1] = {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    -- separator = ' ',
    -- separator_highlight = {colors.bg, colors.bg},
    highlight = {colors.green, colors.bg}
  }
}

gls.right[2] = {
  FileFormat = {
    provider = "FileFormat",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.green, colors.bg}
  }
}

gls.right[3] = {
  GitIcon = {
    provider = function()
      return "  "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.violet, colors.bg}
  }
}

gls.right[4] = {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    highlight = {colors.violet, colors.bg}
  }
}

gls.right[5] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = {colors.green, colors.bg}
  }
}
gls.right[6] = {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " 柳",
    highlight = {colors.orange, colors.bg}
  }
}
gls.right[7] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = {colors.red, colors.bg}
  }
}

gls.right[8] = {
  RainbowBlue = {
    provider = function()
      return "▐"
    end,
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = 'GalaxyTime'
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = "FileTypeName",
    separator = "",
    separator_highlight = {colors.blue, colors.gray},
    highlight = {colors.bg, colors.blue, 'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider = function()
      local file = vim.fn.expand('%:~:.')
      if vim.fn.empty(file) == 1 then return '' end
      if vim.bo.readonly == true then
        return file .. " "
      end
      if vim.bo.modified then
        return file .. ' '
      end
      -- if string.len(file) > 40 then
      --   file = '..' .. string.sub(file,-40)
      -- end
      return file
    end,
    separator = "",
    separator_highlight = {colors.gray, colors.bg},
    condition = condition.buffer_not_empty,
    highlight = {colors.black, colors.gray, 'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = {colors.fg, colors.bg}
  }
}
