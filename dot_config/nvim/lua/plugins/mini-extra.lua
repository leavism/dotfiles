return {
  'echasnovski/mini.extra',
  version = '*',
  dependencies = { 'echasnovski/mini.pick' },
  config = function()
    require('mini.extra').setup()
  end,
}
