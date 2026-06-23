-- return {
--   { "rktjmp/lush.nvim" },
--   { "rktjmp/shipwright.nvim" }, -- Añade esta línea
--
--   {
--     "oncomouse/lushwal.nvim",
--     dependencies = { "rktjmp/lush.nvim", "rktjmp/shipwright.nvim" },
--     lazy = false,
--     priority = 1000,
--     config = function()
--       -- Creamos una función para aplicar tus estilos
--       local function apply_my_highlights()
--         local groups = {
--           "Normal", -- Fondo principal
--           "NormalNC", -- Fondo en ventanas inactivas
--           "NormalFloat", -- Ventanas flotantes (LSP, diagnósticos)
--           "FloatBorder", -- Bordes de ventanas flotantes
--           "SignColumn", -- Columna de signos (iconos de Git/errores)
--           "LineNr", -- Números de línea
--           "CursorLineNr", -- Número de línea actual
--           "EndOfBuffer", -- Los tildes (~) al final del archivo
--           "MsgArea", -- Área de mensajes/comandos abajo
--           "StatusLine", -- Barra de estado (si Lualine no la tapa)
--           "StatusLineNC", -- Barra de estado inactiva
--           "NvimTreeNormal", -- Si usas NvimTree (explorador de archivos)
--         }
--         for _, group in ipairs(groups) do
--           vim.api.nvim_set_hl(0, group, { bg = "none", force = true })
--         end
--
--         -- Arreglo para CursorLine
--         vim.api.nvim_set_hl(0, "CursorLine", {
--           link = "Visual",
--           underline = false,
--           blend = 20,
--         })
--       end
--
--       -- 1. Ejecutar inmediatamente al cargar el plugin
--       vim.cmd.colorscheme("lushwal")
--       apply_my_highlights()
--
--       -- 2. "EL SEGURO": Re-aplicar si algo cambia el esquema después
--       vim.api.nvim_create_autocmd("ColorScheme", {
--         pattern = "lushwal",
--         callback = apply_my_highlights,
--       })
--
--       local highlight_info = vim.api.nvim_get_hl(0, { name = "Keyword" })
--       -- Opcional: Resaltar el número de línea actual para saber dónde estás
--       vim.api.nvim_set_hl(0, "CursorLineNr", { fg = highlight_info.fg, bold = true })
--     end,
--   },
--   {
--     "nvim-lualine/lualine.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" }, -- Para iconos bonitos
--     config = function()
--       require("lualine").setup({
--         options = {
--           theme = "auto", -- 'auto' detectará los colores de lushwal/pywal
--           component_separators = { left = "", right = "" },
--           section_separators = { left = "", right = "" },
--         },
--       })
--     end,
--   },
--   -- NUEVO: Twilight
--   {
--     "folke/twilight.nvim",
--     config = function()
--       require("twilight").setup({
--         dimming = { alpha = 0.4 }, -- Ajusta esto según qué tan oscuro quieras el fondo
--       })
--     end,
--   },
-- }

-- lua/plugins/kanagawa.lua

return {
  -- Cambiamos Nightfox por Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      terminal_colors = true, -- define colores para la terminal integrada
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invierte fondo/texto para búsquedas, matchparen, etc.
      contrast = "hard", -- Puede ser "soft", "medium" o "hard"
      palette_overrides = {},
      overrides = {
        -- Mantenemos tu personalización del modo Visual si te gustaba,
        -- aunque Gruvbox ya trae un buen color por defecto.
        Visual = { bg = "#4e5e70", bold = true },
      },
      dim_inactive = false,
      transparent_mode = true, -- Mantenemos tu preferencia de fondo transparente
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- Actualizamos LazyVim para que use gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Tu plugin Twilight se queda exactamente igual
  {
    "folke/twilight.nvim",
    opts = {
      dimming = { alpha = 0.4 },
    },
  },
}
