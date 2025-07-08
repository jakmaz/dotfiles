return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app and bun install',
  init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
  ft = { 'markdown' },
}
