;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pavel Atanasov"
      user-mail-address "pavel.atanasov2001@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both asume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(prefer-coding-system           'utf-8)
(set-default-coding-systems     'utf-8)
(set-terminal-coding-system     'utf-8)
(set-keyboard-coding-system     'utf-8)
(setq default-buffer-file-encoding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-set-style "k&r")
(setq c-basic-offset 4)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  (pushnew! tree-sitter-major-mode-language-alist
            '(scss-mode . css)))

(defun reo101/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package! org
  :hook (org-mode . reo101/org-mode-setup)
  :custom
  (org-ellipsis " ▼")
  (org-hide-emphasis-markers t)
  (org-src-window-setup 'current-window))

(use-package! org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(font-lock-add-keywords 'org-mode
	  '(("^ *\\([-]\\) "
	     (0 (prog1 () (compose-region (match-beginning 1)
                                          (match-end 1) "•"))))))

(defun reo101/org-mode-visual-fill ()
  (setq visual-fill-column-width 125
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package! visual-fill-column
  :diminish visual-line-mode
  :hook (org-mode . reo101/org-mode-visual-fill))

(use-package! highlight-indent-guides
  :commands highlight-indent-guides-mode
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\»
        highlight-indent-guides-delay 0.01
        highlight-indent-guides-responsive 'top
        highlight-indent-guides-auto-enabled nil)) ;nil

;; (use-package! lsp-mode
;;   :hook ((prog-mode . lsp-deferred))
;;   :commands (lsp lsd-deferred)
;;   :config
;;   (progn
;;     (lsp-register-client
;;      (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
;;                       :major-modes '(c-mode c++-mode)
;;                       :remote? t
;;                       :server-id 'clangd-remote))))

(defun reo101/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package! lsp-mode
  :diminish
  :commands (lsp lsp-deferred)
  ;; :bind-keymap ("C-c l" . lsp-command-map)
  :custom
  (lsp-log-io t)
  ;; (lsp-keymap-prefix "C-c l")
  (lsp-register-client
  (make-lsp-client :new-connection (lsp-stdio-connection "intelephense")
                   :major-modes '(c++-mode)
                   :server-id 'intelephense))
  :hook
  ;; (erlang-mode . lsp)
  (c++-mode . lsp)
  ;; (latex-mode . lsp)
  ;; (latex-math-mode . lsp)
  ;; (php-mode . lsp)
  (lsp-mode . reo101/lsp-mode-setup)
  (lsp-mode . lsp-enable-which-key-integration))

(use-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui
  :custom
  (lsp-ui-sideline-enable t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'bottom))

(use-package! lsp-origami
  :hook
  (erlang-mode . origami-mode)
  (origami-mode . lsp-origami-mode))

(use-package! lsp-ivy :commands lsp-ivy-workspace-symbol)

; (use-package! origami
;   :bind-keymap ("C-c o" . origami-mode-map)
;   :bind (:map origami-mode-map
;               ("C-c o o" . origami-open-node)
;               ("C-c o O" . origami-open-node-recursively)
;               ("C-c o c" . origami-close-node)
;               ("C-c o C" . origami-close-node-recursively)
;               ("C-c o a" . origami-toggle-node)
;               ("C-c o A" . origami-recursively-toggle-node)
;               ("C-c o R" . origami-open-all-nodes)
;               ("C-c o M" . origami-close-all-nodes)
;               ("C-c o v" . origami-show-only-node)
;               ("C-c o k" . origami-previous-fold)
;               ("C-c o j" . origami-forward-fold)
;               ("C-c o x" . origami-reset)))

(use-package! company
  :after lsp-mode
  :diminish
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  :bind (:map company-active-map
              ("M-n" . nil)
              ("M-p" . nil)
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :hook (lsp-mode . company-mode))

;; (use-package! company-box
;;   :diminish
;;   :hook (company-mode . company-box-mode))

; (defvar my-term-shell "/bin/zsh")
; (defadvice ansi-term (before force-bash)
;   (interactive (list my-term-shell)))
; (ad-activate 'ansi-term)
; (global-set-key (kbd "<M-return>") 'ansi-term)

(use-package! sudo-edit
  :bind ("C-c s" . sudo-edit))

; (use-package! ivy
;   :diminish
;   :bind (:map ivy-minibuffer-map
;               ("TAB" . ivy-alt-done))
;   :config (ivy-mode 1))
; (use-package! ivy-rich
;   :init (ivy-rich-mode 1))

; (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
; (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; (prettify-utils-add-hook tex-mode
;;                          ("\\smallo" "o"))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                         :time-grid t
                                         :scheduled today)
                                  (:name "Due today"
                                         :deadline today)
                                  (:name "Important"
                                         :priority "A")
                                  (:name "Overdue"
                                         :deadline past)
                                  (:name "Due soon"
                                         :deadline future)
                                  (:name "Big Outcomes"
                                         :tag "bo")))
  :config
  (org-super-agenda-mode))
