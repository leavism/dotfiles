local colors_name = "earthbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require("lush")
local hsl = lush.hsl
local util = require("zenbones.util")

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
  palette = util.palette_extend({
    bg = hsl("#e5c7a9"),
    fg = hsl("#292520"),
  }, bg)
else
  palette = util.palette_extend({
    bg = hsl(34, 10, 14),
    fg = hsl(32, 45, 78),
    overlay = hsl(35, 8, 47),
    red = hsl(6, 54, 53),
    green = hsl(87, 30, 52),
    amber = hsl(33, 67, 49),
    sky = hsl(191, 31, 65),
  }, bg)
end

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
---@diagnostic disable: undefined-global
local specs = lush.extends({ base_specs }).with(function(injected_functions)
  local sym = injected_functions.sym
  return {
    Statement({ fg = palette.fg }),
    Special({ fg = palette.fg.sa(25).da(30).ro(5) }),
    Number({ fg = palette.sky }),
    Type({ fg = palette.amber, gui = "italic" }),

    Function({ fg = palette.fg.da(45), gui = "bold" }),
    sym("@function.method.call")({ Function }),
    sym("@lsp.type.method")({ Function }),

    Return({ fg = palette.green }),
    sym("@keyword.return")({ Return }),

    sym("@tag.builtin")({ fg = Special.fg }),

    Comment({ fg = palette.bg.de(25).li(25) }),
    sym("@keyword.jsdoc")({ fg = Comment.fg.sa(10).li(10).ro(-10) }),
    sym("@variable.parameter.jsdoc")({ fg = Comment.fg.sa(30).li(10) }),
  }
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
