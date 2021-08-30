  vim.g.material_italic_comments = true
  -- vim.g.material_italic_keywords = true
  -- vim.g.material_italic_functions = true
  -- vim.g.material_italic_variables = true
  -- vim.g.material_italic_strings = true
  -- vim.g.material_contrast = true
  -- vim.g.material_borders = false
  -- vim.g.material_disable_background = false
  vim.g.material_style = 'darker'
  require('material').set()

  ---- color hack for tabs ----
  vim.cmd [[highlight! link Whitespace NonText]]




