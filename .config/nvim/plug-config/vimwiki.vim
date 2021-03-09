let wiki = {}
let wiki.path = "$HOME/vimwiki"
let wiki.template_path= "$HOME/vimwiki/templates/"
let wiki.template_default= "def_template"
let wiki.syntax = "markdown"
let wiki.ext = ".md"
" let wiki.path_html = "$HOME/vimwiki/site_html/"
let wiki.path_html = "$HOME/vimwiki_html"
let wiki.custom_wiki2html= "vimwiki_markdown"
let wiki.html_filename_parameterization = 1
let wiki.template_ext = ".html"
let wiki.nested_syntaxes = {"python": "python", "c++": "cpp", "bash": "bash"}
let g:vimwiki_list = [wiki]

let g:vimwiki_valid_html_tags = "b, i, s, u, sub, sup, kbd, br, hr, pre, script"
