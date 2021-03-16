let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB', 'vscode-go', 'vscode-bash-debug', 'vscode-java-debug', 'debugger-for-chrome' ]
"let g:vimspector_enable_mappings = 'HUMAN'V

" F5	            When debugging, continue. Otherwise start debugging.	    vimspector#Continue()
" F3	            Stop debugging.	                                            vimspector#Stop()
" F4	            Restart debugging with the same configuration.	            vimspector#Restart()
" F6	            Pause debugee.	                                            vimspector#Pause()
" F9	            Toggle line breakpoint on the current line.	                vimspector#ToggleBreakpoint()
" <leader>F9	    Toggle conditional line breakpoint on the current line.	    vimspector#ToggleBreakpoint( { trigger expr, hit count expr } )
" F8	            Add a function breakpoint for the expression under cursor	vimspector#AddFunctionBreakpoint( '<cexpr>' )
" <leader>F8	    Run to Cursor	                                            vimspector#RunToCursor()
" F10	            Step Over	                                                vimspector#StepOver()
" F11	            Step Into	                                                vimspector#StepInto()
" F12	            Step out of current function scope	                        vimspector#StepOut()

nnoremap <leader>m :MaximizerToggle!<CR>
nmap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

noremap <leader>dk :!clear;echo;echo <C-r>=expand('%.r')<CR> \| xargs java<CR>
autocmd FileType java nnoremap <leader>dd :CocCommand java.debug.vimspector.start<CR>

function! JavaStartDebugCallback(err, port)
  execute "cexpr! 'Java debug started on port: " . a:port . "'"
  call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
endfunction

function JavaStartDebug()
  call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
endfunction

" nmap <F5> :call JavaStartDebug()<CR>
autocmd FileType java nmap <leader>dd :CocCommand java.debug.vimspector.start<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

" <Plug>VimspectorStop
" <Plug>VimspectorPause
" <Plug>VimspectorAddFunctionBreakpoint
