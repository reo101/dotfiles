(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
;; (setq use-package-always-ensure t) ;; use straight.el

(defun reo101/display-startup-time ()
  (message "🚀 Emacs loaded in %s with %d garbage collections."
           (float-time (time-subtract after-init-time before-init-time))
           gcs-done))

(add-hook 'emacs-startup-hook #'reo101/display-startup-time)

(defvar server-socket-dir
  (and (featurep 'make-network-process '(:family local))
   (format "%s/emacs%d" (or (getenv "TMPDIR") "/data/data/com.termux/files/usr/var/run") (user-uid)))
  "The directory in which to place the server socket.
  If local sockets are not supported, this is nil.")

;;   (use-package bug-hunter)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)

(defun reo101/secret (&optional name)
  "Read a Lisp structure from the secret file.
When NAME is provided, return the value associated to this key."
  (let ((file (expand-file-name ".secrets.eld")))
    (when (file-exists-p file)
      (with-demoted-errors "Error while parsing secret file: %S"
        (with-temp-buffer
          (insert-file-contents file)
          (if-let ((content (read (buffer-string)))
                   (name))
              (alist-get name content)
            content))))))

(use-package general
  :config
  (general-create-definer reo101/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (reo101/leader-keys
    "t"  '(:ignore t :which-key "Toggle")
    "tt" '(reo101/toggle-transparency :which-key "Transparency")
    "c" '(:ignore c :which-key "Choose")
    "ct" '(counsel-load-theme :which-key "Theme")))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (defun reo101/evil-hook ()
;;   (dolist (mode '(custom-mode
;;                   eshell-mode
;;                   git-rebase-mode
;;                   erc-mode
;;                   circe-server-mode
;;                   circe-chat-mode
;;                   circe-query-mode
;;                   sauron-mode
;;                   term-mode))
;;     (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init      ;; tweak evil's configuration before loading it
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-d-scroll t)
  (setq evil-want-C-o-jump t)
  (setq evil-want-C-i-jump t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-undo-system 'undo-tree)
  ;; (setq evil-cross-lines t) ;; Shadowed by evil-snipe
  ;; :hook (evil-mode . reo101/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line) ;; FIXME
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package evil-tutor)

(use-package evil-goggles
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

;; TODO

(use-package evil-snipe
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode))

(use-package evil-anzu
  :config
  (global-anzu-mode))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(reo101/leader-keys
  "w" '(:keymap evil-window-map :which-key "Window"))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(reo101/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(setq inhibit-startup-message t)

(if (display-graphic-p)
    (progn
      ;; (tooptip-mode -1)
      ))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(if (display-graphic-p)
    (progn
      (set-fringe-mode 7)))

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                doc-view-mode-hook
                treemacs-mode-hook
                undo-tree-visualizer-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-frame-parameter (selected-frame) 'alpha '(95 . 85))
(add-to-list 'default-frame-alist '(alpha . (95 . 85)))

(defun reo101/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(95 . 85) '(100 . 100)))))

(set-face-attribute 'default nil :font "Fira Code Nerd Font" :height 175) ;; TODO use vars

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Nerd Font Mono" :height 175)

;; Set the variable pitch face
;; (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 175 :weight 'regular)
(set-face-attribute 'variable-pitch nil :font "Fira Code Nerd Font" :height 175 :weight 'regular)

(use-package unicode-fonts
  :config
  (unicode-fonts-setup))

;; (use-package ligature
;;   :load-path "/home/reo101/.local/src/ligature.el"
;;   :config
;;   ;; Enable the "www" ligature in every possible major mode
;;   (ligature-set-ligatures 't '("www"))
;;   ;; Enable traditional ligature support in eww-mode, if the
;;   ;; `variable-pitch' face supports it
;;   (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
;;   ;; Enable all Cascadia Code ligatures in programming modes
;;   (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
;;                                        ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
;;                                        "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
;;                                        "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
;;                                        "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
;;                                        "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
;;                                        "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
;;                                        "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
;;                                        ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
;;                                        "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
;;                                        "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
;;                                        "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
;;                                        "\\\\" "://"))
;;   ;; Enables ligature checks globally in all buffers. You can also do it
;;   ;; per mode with `ligature-mode'.
;;   (global-ligature-mode t))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-monokai-classic t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; (use-package mood-one-theme)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package all-the-icons)

(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)

(require 'epa)
(epa-file-enable)
(setq epg-gpg-program "$PREFIX/bin/gpg")
;; Don't display graphic prompt in terminal
(when (not (display-graphic-p))
  (setq epg-gpg-program "$PREFIX/bin/gpg"))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(use-package which-key
  :init
  (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " → " )
  (which-key-mode))

(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config (counsel-mode))
(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :custom
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))
(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer)
  (ivy-rich-mode 1)) ;; this gets us descriptions in M-x.
(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-decribe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(setq ivy-initial-inputs-alist nil)

(use-package smex)
(smex-initialize)

(defun reo101/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode)
  (lsp-lens-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  (erlang-mode . lsp)
  (c++-mode . lsp)
  (php-mode . lsp)
  (lsp-mode . reo101/lsp-mode-setup)
  (lsp-mode . lsp-diagnostics-modeline-mode)
  (lsp-mode . lsp-enable-which-key-integration)
  ;; :init
  ;;  (reo101/leader-keys
  ;;    "l" '(lsp-keymap :which-key "LSP"))
  :custom
  (lsp-log-io t)
  (lsp-keymap-prefix "C-c l")
  (lsp-diagnostics-modeline-scope :project)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "intelephense")
                    :major-modes '(php-mode)
                    :server-id 'intelephense))
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :commands (lsp-ui)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-delay 0.75)
  (lsp-ui-doc-max-height 200)
  (lsp-ui-doc-position 'bottom) ; 'at-point
  (lsp-ui-sideline-enable t))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-origami
  :hook
  (erlang-mode . origami-mode)
  (origami-mode . lsp-origami-mode))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 4))

;; todo

(use-package haskell-mode

  :config
  (defcustom haskell-formatter 'ormolu
    "The Haskell formatter to use. One of: 'ormolu, 'stylish, nil. Set it per-project in .dir-locals."
    :safe 'symbolp)

  (defun haskell-smart-format ()
    "Format a buffer based on the value of 'haskell-formatter'."
    (interactive)
    (cl-ecase haskell-formatter
      ('ormolu (ormolu-format-buffer))
      ('stylish (haskell-mode-stylish-buffer))
      (nil nil)
      ))

  (defun haskell-switch-formatters ()
    "Switch from ormolu to stylish-haskell, or vice versa."
    (interactive)
    (setq haskell-formatter
          (cl-ecase haskell-formatter
            ('ormolu 'stylish)
            ('stylish 'ormolu)
            (nil nil))))

  ;; haskell-mode doesn't know about newer GHC features.
  (let ((new-extensions '("QuantifiedConstraints"
                          "DerivingVia"
                          "BlockArguments"
                          "DerivingStrategies"
                          "StandaloneKindSignatures"
                          "ImportQualifiedPost"
                          )))
    (setq
     haskell-ghc-supported-extensions
     (append haskell-ghc-supported-extensions new-extensions)))

  :bind (:map haskell-mode-map
              ("C-c a c" . haskell-cabal-visit-file)
              ("C-c a i" . haskell-navigate-imports)
              ("C-c M"   . haskell-compile)
              ("C-c a I" . haskell-navigate-imports-return)))

(use-package haskell-snippets
  :after (haskell-mode yasnippet)
  :defer)

(use-package lsp-haskell
  :hook (haskell-mode . lsp)
  :custom
  (lsp-haskell-process-path-hie "haskell-language-server-wrapper")
  (lsp-haskell-process-args-hie '()))

(use-package ormolu)

(use-package dap-mode
  ;; :bind
  ;; (("C-c b b" . dap-breakpoint-toggle)
  ;;  ("C-c b r" . dap-debug-restart)
  ;;  ("C-c b l" . dap-debug-last)
  ;;  ("C-c b d" . dap-debug))
  :init
  ;; (require 'dap-go)
  ;; NB: dap-go-setup appears to be broken, so you have to download the extension from GH, rename its file extension
  ;; unzip it, and copy it into the config so that the following path lines up
  ;; (setq dap-go-debug-program '("node" "/pathToGoDebugAdapter/debugAdapter.js"))
  :config
  (dap-mode)
  (dap-auto-configure-mode)
  (dap-ui-mode)
  (dap-ui-controls-mode))

(reo101/leader-keys
  "l"    '(:ignore l   :which-key "LSP")
  "ld"   '(:ignore ld  :which-key "DAP")
  "ldb"  '(:ignore ldb :which-key "Breakpints")
  "ldbb" '(dap-breakpoint-toggle :which-key "Toggle breakpoint")
  "ldr"  '(dap-debug-restart     :which-key "Reset debugger")
  "ldl"  '(dap-debug-last        :which-key "Last debugger")
  "lbd"  '(dap-debug             :which-key "Start debugging"))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  ;; :config
  ;; (global-company-mode t)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Merged with evil-collection
;; https://github.com/syl20bnr/spacemacs/issues/14321
;; (use-package evil-magit
;;   :after magit)

(use-package forge
  :custom
  (setq auth-sources '("~/.authinfo.gpg")))

(setq dotfiles-git-dir (concat "--git-dir=" (expand-file-name "~/dotfiles")))
(setq dotfiles-work-tree (concat "--work-tree=" (expand-file-name "~")))
;; function to start magit on dotfiles
(defun dotfiles-magit-status ()
  (interactive)
  (add-to-list 'magit-git-global-arguments dotfiles-git-dir)
  (add-to-list 'magit-git-global-arguments dotfiles-work-tree)
  (call-interactively 'magit-status))

(reo101/leader-keys
  "g"  '(:ignore t :which-key "Git")
  "gd" '(dotfiles-magit-status :which-key "Dotfiles status"))

;; wrapper to remove additional args before starting magit
(defun magit-status-with-removed-dotfiles-args ()
  (interactive)
  (setq magit-git-global-arguments (remove dotfiles-git-dir magit-git-global-arguments))
  (setq magit-git-global-arguments (remove dotfiles-work-tree magit-git-global-arguments))
  (call-interactively 'magit-status))
;; redirect global magit hotkey to our wrapper
(reo101/leader-keys
  "g"  '(:ignore t :which-key "Git")
  "gg" '(magit-status-with-removed-dotfiles-args :which-key "Git status"))

(require 'dash)

(defmacro pretty-magit (WORD ICON PROPS &optional NO-PROMPT?)
  "Replace sanitized WORD with ICON, PROPS and by default add to prompts."
  `(prog1
       (add-to-list 'pretty-magit-alist
                    (list (rx bow (group ,WORD (eval (if ,NO-PROMPT? "" ":"))))
                          ,ICON ',PROPS))
     (unless ,NO-PROMPT?
       (add-to-list 'pretty-magit-prompt (concat ,WORD ": ")))))

(setq pretty-magit-alist nil)
(setq pretty-magit-prompt nil)
(pretty-magit "Feature" ? (:foreground "slate gray" :height 1.2))
(pretty-magit "Add"     ? (:foreground "#375E97" :height 1.2))
(pretty-magit "Fix"     ? (:foreground "#FB6542" :height 1.2))
(pretty-magit "Clean"   ? (:foreground "#FFBB00" :height 1.2))
(pretty-magit "Docs"    ? (:foreground "#3F681C" :height 1.2))
(pretty-magit "master"  ? (:box t :height 1.2) t)
(pretty-magit "origin"  ? (:box t :height 1.2) t)

(defun add-magit-faces ()
  "Add face properties and compose symbols for buffer from pretty-magit."
  (interactive)
  (with-silent-modifications
    (--each pretty-magit-alist
      (-let (((rgx icon props) it))
        (save-excursion
          (goto-char (point-min))
          (while (search-forward-regexp rgx nil t)
            (compose-region
             (match-beginning 1) (match-end 1) icon)
            (when props
              (add-face-text-property
               (match-beginning 1) (match-end 1) props))))))))

(advice-add 'magit-status :after 'add-magit-faces)
(advice-add 'magit-refresh-buffer :after 'add-magit-faces)

(setq use-magit-commit-prompt-p nil)
(defun use-magit-commit-prompt (&rest args)
  (setq use-magit-commit-prompt-p t))

(defun magit-commit-prompt ()
  "Magit prompt and insert commit header with faces."
  (interactive)
  (when use-magit-commit-prompt-p
    (setq use-magit-commit-prompt-p nil)
    (insert (ivy-read "Commit Type " pretty-magit-prompt
                      :require-match t :sort t :preselect "Add: "))
    ;; Or if you are using Helm...
    ;; (insert (helm :sources (helm-build-sync-source "Commit Type "
    ;;                          :candidates pretty-magit-prompt)
    ;;               :buffer "*magit cmt prompt*"))
    ;; I haven't tested this but should be simple to get the same behaior
    (add-magit-faces)
    (evil-insert 1)  ; If you use evil
    ))

(remove-hook 'git-commit-setup-hook 'with-editor-usage-message)
(add-hook 'git-commit-setup-hook 'magit-commit-prompt)
(advice-add 'magit-commit :after 'use-magit-commit-prompt)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects")
    (setq projectile-project-search-path '("~/Projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(reo101/leader-keys
  "p" '(:keymap projectile-command-map :which-key "Projectile" :package projectile))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)) ;; move parenthesis when uncommentig VVVV
;; (tree-sitter-hl-mode) ;;TODO only certain modes
(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (tree-sitter-langs-install-grammars))

(defun reo101/highlighter (level responsive display)
  (if (> 2 level)
      nil
    (highlight-indent-guides--highlighter-default level responsive display)))


  (use-package highlight-indent-guides
    :commands highlight-indent-guides-mode
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
    (setq highlight-indent-guides-method 'character
          highlight-indent-guides-character ?\»
          highlight-indent-guides-delay 0.01
          highlight-indent-guides-responsive 'top
          highlight-indent-guides-auto-enabled nil ;nil
          highlight-indent-guides-highlighter-function 'reo101/highlighter))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package undo-tree
  :init
  (global-undo-tree-mode)
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.config/reomacs/undo"))))

(use-package rainbow-delimiters)

(add-hook 'activate-mark-hook 'rainbow-delimiters-mode-disable)
(add-hook 'deactivate-mark-hook 'rainbow-delimiters-mode-enable)

(use-package electric-case)
(use-package electric-cursor)
(use-package electric-operator)

(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(add-hook 'c++-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'electric-pair-pairs) (cons ?< ?>))))
(setq electric-pair-pairs '(
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\{ . ?\})
                            (?\" . ?\")))
(electric-pair-mode t)
(use-package electric-spacing)

(use-package beacon
  :init
  (beacon-mode 1)
  :config
  (setq beacon-color "#336633")
  (setq beacon-size 50)
  (setq beacon-push-mark 35))

(use-package rainbow-mode
  :diminish
  :hook (prog-mode . rainbow-mode))

(use-package elcord
  :config
  (elcord-mode))

(global-prettify-symbols-mode 1)
(setq prettify-symbols-unprettify-at-point 'right-edge)

;;  (use-package wakatime-mode
;;    :config
;;    (setq wakatime-api-key (reo101/secret 'wakatime-api-key))
;;    (global-wakatime-mode))

(defun reo101/parrot-animate-when-compile-success (buffer result)
  (if (string-match "^finished" result)
      (parrot-start-animation)))

(use-package parrot
  :ensure t
  :config
  (parrot-mode)
  (add-hook 'before-save-hook 'parrot-start-animation)
  (add-to-list 'compilation-finish-functions 'reo101/parrot-animate-when-compile-success))

;;   (defun reo101/meme-from-clipboard ()
;;     "Create a meme using an image from clipboard"
;;     (interactive)
;;     (unless (executable-find "pngpaste")
;;       (user-error "please install pngpaste"))
;;
;;     (let* ((filepath (make-temp-file "clipboard" nil ".png"))
;;            (command (format "pngpaste %s" filepath))
;;            (command-stdout (shell-command-to-string command)))
;;       ;; pngpaste returns "" when found a valid image in the clipboard
;;       (unless (string-equal command-stdout "")
;;         (user-error (string-trim command-stdout)))
;;
;;       (switch-to-buffer (get-buffer-create "*meme*"))
;;       (meme-mode)
;;       (meme--setup-image filepath)))

;;  (use-package imgur
;;    :ensure t
;;    :defer t
;;    :straight (imgur
;;               :type git
;;               :host github
;;               :repo "myuhe/imgur.el"))
;;
;;  (use-package meme
;;    :ensure t
;;    :defer t
;;    :commands (meme-mode meme)
;;    :straight (meme
;;               :type git
;;               :host github
;;               :repo "larsmagne/meme")
;;    :config
;;    ;; fix to be able to read images, straight.el put files in a different directory so we have to
;;    ;; move them to the right one
;;    (let ((images-dest-dir (concat user-emacs-directory "straight/build/meme/images"))
;;          (images-source-dir (concat user-emacs-directory "straight/repos/meme/images")))
;;      (unless (file-directory-p images-dest-dir)
;;        (shell-command (format "cp -r %s %s" images-source-dir images-dest-dir)))))

(defun reo101/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent 1))

(defun reo101/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil                  :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil                 :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil              :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil       :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil             :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil              :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . reo101/org-mode-setup)
  :custom
  (org-ellipsis " ▼")  ;; " ▾"
  (org-hide-emphasis-markers t)
  (org-src-window-setup 'current-window)
  (org-agenda-start-with-log-mode t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-agenda-files
   '("~/Org/Tasks.org"
     "~/Org/Habits.org"
     "~/Org/Birthdays.org")
   :config
   (reo101/org-font-setup)))

;; (defun reo101/org-mode-visual-fill ()
;;  (setq visual-fill-column-width 125
;;        visual-fill-column-center-text t)
;;  (visual-fill-column-mode 1))
;;
;; (use-package! visual-fill-column
;;   :diminish visual-line-mode
;;   :hook (org-mode . reo101/org-mode-visual-fill))

(require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

(use-package org-superstar
  :after org
  :config
  (set-face-attribute 'org-superstar-item nil :height 1.3)
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.4)
  (set-face-attribute 'org-superstar-leading nil :height 1.5)
  ;; Set different bullets, with one getting a terminal fallback.
  (setq org-superstar-headline-bullets-list
        '("◉" "○" "●" "○" "●" "○" "●"))
  ;; Stop cycling bullets to emphasize hierarchy of headlines.
  (setq org-superstar-cycle-headline-bullets nil)
  ;; Hide away leading stars on terminal.
  (setq org-superstar-leading-fallback ?\s)
  :hook (org-mode . org-superstar-mode))

(setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

(advice-add 'org-refile :after 'org-save-all-org-buffers) ;; Save Org buffers after refiling

(setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

(setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

(setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Org/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Org/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/Org/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/Org/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ("m" "Metrics Capture")
      ("mw" "Weight" table-line (file+headline "~/Org/Metrics.org" "Weight")
       "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

;; (defun reo101/org-mode-checkbox-todo ()
;;   "Switch header TODO state to DONE when all checkboxes are ticked, to TODO otherwise"
;;   (let ((todo-state (org-get-todo-state)) beg end)
;;     (unless (not todo-state)
;;       (save-excursion
;;         (org-back-to-heading t)
;;         (setq beg (point))
;;         (end-of-line)
;;         (setq end (point))
;;         (goto-char beg)
;;         (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
;;                                end t)
;;             (if (match-end 1)
;;                 (if (equal (match-string 1) "100%")
;;                     (unless (string-equal todo-state "DONE")
;;                       (org-todo 'done))
;;                   (unless (string-equal todo-state "TODO")
;;                     (org-todo 'todo)))
;;               (if (and (> (match-end 2) (match-beginning 2))
;;                        (equal (match-string 2) (match-string 3)))
;;                   (unless (string-equal todo-state "DONE")
;;                     (org-todo 'done))
;;                 (unless (string-equal todo-state "TODO")
;;                   (org-todo 'todo)))))))))
;;                             ^^^^^^^^^ <- 9

;; (add-hook 'org-checkbox-statistics-hook 'reo101/org-checkbox-todo)

(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "†")
                                       ("#+END_SRC" . "†")
                                       ("#+begin_src" . "†")
                                       ("#+end_src" . "†")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))

(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)

;; (map! :leader
;;        (:prefix ("t" . "toggle")
;;         :desc "Transparency" "t" #'reo101/toggle-transparency))

(defun reo101/org-mode-show-current-heading-tidily ()
  (interactive)
  "Show next entry, keeping other entries closed."
  (if (save-excursion (end-of-line) (outline-invisible-p))
      (progn (org-show-entry) (show-children))
    (outline-back-to-heading)
    (unless (and (bolp) (org-on-heading-p))
      (org-up-heading-safe)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (show-children)))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist
             '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist
             '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist
             '("py" . "src python"))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(push '("conf-unix" . conf-unix) org-src-lang-modes)

(defun reo101/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/reomacs/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'reo101/org-babel-tangle-config)))

;; (use-package org-fragtog
;;   :hook (org-mode . org-fragtog-mode))

(use-package auctex
  :defer t)

(use-package latex-preview-pane
  :defer t)

(use-package evil-tex
  :hook(LaTeX-mode . evil-tex-mode))

(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)

(setq TeX-electric-sub-and-superscript 1)

;; (use-package tex-fold
;;   :hook (LaTeX-mode . TeX-fold-mode))

(use-package xenops
  :hook (LaTeX-mode . xenops-mode))
