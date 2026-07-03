(require 'package)
(add-to-list 'package-archives
             '("melpa" .  "https://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Load main libraries

(require 'jwl-emacs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-default-mode 'plain-tex-mode)
 '(ansi-color-names-vector
   ["#fdf6e3" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198"
    "#657b83"])
 '(blink-cursor-mode nil)
 '(c-basic-offset 4)
 '(claude-code-ide-cli-path "/Users/james/.claude/local/claude")
 '(claude-code-ide-debug nil)
 '(claude-code-ide-focus-claude-after-ediff nil)
 '(claude-code-ide-show-claude-window-in-ediff nil)
 '(claude-code-ide-system-prompt nil)
 '(claude-code-ide-use-side-window nil)
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(css-indent-offset 2)
 '(cursor-color "#5c5cff")
 '(custom-enabled-themes '(night-owl))
 '(custom-safe-themes
   '("7ce3a35c349be254e82a3c4f0f555639e729ef07cdd1c5c9f0358163eff99fe6"
     "04d35fa12c8caddd94f876ce51b59783b658629b6314d70c87c5406e6b7ff910"
     "d143b38de4a3d1f02077f9b53e0b9405177321d98497e27ef8d2876aaaba5b75"
     "0b6747ef7386c4bc85a388467ca3dc2dc9dba74126456428f620ea37894b4261"
     "30fe7e72186c728bd7c3e1b8d67bc10b846119c45a0f35c972ed427c45bacc19"
     "fe6330ecf168de137bb5eddbf9faae1ec123787b5489c14fa5fa627de1d9f82b"
     "1177fe4645eb8db34ee151ce45518e47cc4595c3e72c55dc07df03ab353ad132"
     "59e139601f357dba80b87f7878f2da03d66ef118d727bc7bb3d30b6509391ef0"
     "e5cf165e63eb7a4f2a8be7da9445d47d7b53f3cdc784e6e384b5fe870d37931f"
     "ef8251b88d52102548978a98df8389bf540e104f7c197c9b299041739dbdc6aa"
     "68769179097d800e415631967544f8b2001dae07972939446e21438b1010748c"
     "e890fd7b5137356ef5b88be1350acf94af90d9d6dd5c234978cd59a6b873ea94"
     "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e"
     "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4"
     "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879"
     "085b401decc10018d8ed2572f65c5ba96864486062c0a2391372223294f89460"
     "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365"
     "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6"
     "907ac699721b960f43c1d9825f956179901650dc7ad25595dcdcc18683bbd1f9"
     default))
 '(default-frame-alist '((vertical-scroll-bars)))
 '(display-time-mail-face nil)
 '(erc-auto-query 'window-noselect)
 '(erc-generate-log-file-name-function 'erc-generate-log-file-name-short)
 '(erc-join-buffer 'bury)
 '(erc-kill-server-buffer-on-quit t)
 '(erc-log-channels-directory "~/.emacs.d/logs")
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(erc-modules
   '(autojoin button completion fill irccontrols log match netsplit
              networks noncommands notify ring services stamp unmorse))
 '(erc-quit-reason 'erc-quit-reason-normal)
 '(erc-server-auto-reconnect t)
 '(erc-server-coding-system '(utf-8 . utf-8))
 '(erc-server-reconnect-attempts t)
 '(erc-server-reconnect-timeout 7)
 '(erc-track-exclude-types '("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353"))
 '(erc-track-switch-direction 'newest)
 '(erc-user-full-name "James Long")
 '(evil-want-fine-undo t)
 '(explicit-shell-file-name nil)
 '(face-font-family-alternatives '(("courier" "fixed") ("helv" "helvetica" "arial" "fixed")))
 '(fci-rule-color "#F2F2F2")
 '(flycheck-check-syntax-automatically '(save idle-change idle-buffer-switch mode-enabled))
 '(flycheck-disabled-checkers '(javascript-jshint))
 '(flycheck-idle-buffer-switch-delay 0.3)
 '(flycheck-idle-change-delay 0.5)
 '(foreground-color "#5c5cff")
 '(fringe-mode 10 nil (fringe))
 '(fzf/executable "/opt/homebrew/bin/fzf")
 '(global-linum-mode nil)
 '(grep-find-command '("find . -type f -exec grep -nHi -e  {} +" . 35))
 '(grep-save-buffers nil)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-tail-colors
   '(("#F2F2F2" . 0) ("#B4C342" . 20) ("#69CABF" . 30) ("#6DA8D2" . 50)
     ("#DEB542" . 60) ("#F2804F" . 70) ("#F771AC" . 85)
     ("#F2F2F2" . 100)))
 '(hippie-expand-try-functions-list
   '(try-expand-all-abbrevs try-expand-list try-expand-line
                            try-expand-dabbrev
                            try-expand-dabbrev-all-buffers
                            try-expand-dabbrev-from-kill
                            try-complete-lisp-symbol-partially
                            try-complete-lisp-symbol))
 '(icicle-reminder-prompt-flag 4)
 '(indent-tabs-mode nil)
 '(inf-clojure-load-command "(clojure.core/load-file \"%s\")")
 '(inf-clojure-program "./build client")
 '(inhibit-startup-screen t)
 '(javascript-auto-indent-flag t)
 '(javascript-indent-level 4)
 '(js-indent-level 2)
 '(js-switch-indent-offset 2)
 '(js2-allow-keywords-as-property-names t)
 '(js2-basic-offset 2)
 '(js2-concat-multiline-strings nil)
 '(js2-global-externs nil)
 '(js2-highlight-level 2)
 '(js2-mirror-mode nil)
 '(js2-mode-show-parse-errors nil)
 '(js2-mode-show-strict-warnings nil)
 '(js2-strict-inconsistent-return-warning nil)
 '(large-file-warning-threshold nil)
 '(line-spacing nil)
 '(linum-delay nil)
 '(linum-format "%3d ")
 '(longlines-wrap-follows-window-size nil)
 '(ls-lisp-emulation nil)
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#222912")
 '(main-line-color2 "#09150F")
 '(menu-bar-mode nil)
 '(merlin-debug nil)
 '(minibuffer-auto-raise t)
 '(minibuffer-prompt-properties
   '(read-only t point-entered minibuffer-avoid-prompt face
               minibuffer-prompt))
 '(muse-project-alist
   '(("WikiPlanner"
      ("~/plans" :default "index" :major-mode planner-mode :visit-link
       planner-visit-link))))
 '(no-easy-keys-minor-mode nil)
 '(ns-alternate-modifier 'meta)
 '(ns-command-modifier 'meta)
 '(org-agenda-files '("~/todo/main.org"))
 '(org-cycle-separator-lines 1)
 '(org-export-preserve-breaks nil)
 '(org-list-empty-line-terminates-plain-lists nil)
 '(org-log-done nil)
 '(org-publish-project-alist
   '(("tasks" :base-directory "~/tasks/" :base-extension "org"
      :publishing-directory "~/tasks-html/")))
 '(org-startup-folded 'content)
 '(outline-minor-mode-prefix "\3@")
 '(outline-regexp " *////+" t)
 '(package-selected-packages
   '(ace-jump-mode alchemist ample-zen-theme assemblage-theme
                   auto-complete caml claude-code-ide coffee-mode
                   color-theme company elisp-slime-nav evil flycheck
                   fzf haml-mode idle-highlight-mode ido-ubiquitous
                   inf-clojure js-comint js2-mode late-night-theme
                   lineno lua-mode markdown-mode monokai-theme
                   multi-term night-owl-theme nrepl paredit
                   pastels-on-dark-theme qsimpleq-theme rust-mode
                   smooth-scroll solarized-theme starter-kit
                   swift-mode tide transient tuareg undo-tree vterm w3
                   web-mode))
 '(package-vc-selected-packages
   '((claude-code-ide :url
                      "https://github.com/manzaltu/claude-code-ide.el")))
 '(perl-indent-level 4 t)
 '(planner-use-other-window nil)
 '(pos-tip-background-color "#FFF9DC")
 '(pos-tip-foreground-color "#011627")
 '(powerline-color1 "#222912")
 '(powerline-color2 "#09150F")
 '(prettier-args
   '("--parser" "typescript" "--print-width" "120" "--no-semi"))
 '(prettier-command "/Users/james/.yarn/bin/prettier")
 '(python-check-command "epylint")
 '(python-guess-indent t)
 '(python-honour-comment-indentation nil)
 '(python-indent-guess-indent-offset t)
 '(python-indent-string-contents t)
 '(quack-default-program "gsc")
 '(quack-programs
   '("gsc" "bigloo" "csi" "csi -hygienic" "gosh" "gsi"
     "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z"
     "mzscheme" "mzscheme -il r6rs" "mzscheme -il typed-scheme"
     "mzscheme -M errortrace" "mzscheme3m" "mzschemecgc" "rs" "scheme"
     "scheme48" "scsh" "sisc" "stklos" "sxi"))
 '(quack-run-scheme-always-prompts-p nil)
 '(quack-run-scheme-prompt-defaults-to-last-p nil)
 '(quack-switch-to-scheme-method 'cmuscheme)
 '(rst-adornment-faces-alist
   '((t . font-lock-keyword-face) (nil . font-lock-keyword-face)
     (1 . default) (2 . default) (3 . default) (4 . default)
     (5 . rst-level-5-face) (6 . rst-level-6-face)
     (1 . rst-level-1-face) (2 . rst-level-2-face)
     (3 . rst-level-3-face) (4 . rst-level-4-face)
     (5 . rst-level-5-face) (6 . rst-level-6-face)))
 '(safe-local-variable-values '((encoding . utf-8) (Syntax . Scheme) (Package . Scheme)))
 '(scheme-mit-dialect nil)
 '(scheme-program-name "gsc")
 '(scroll-margin 4)
 '(send-mail-function 'smtpmail-send-it)
 '(sh-basic-offset 4)
 '(shell-popd-regexp "\\-")
 '(shell-prompt-pattern "^[^#$%>\12]*[#$%>] *")
 '(shell-pushd-regexp "pushd")
 '(show-paren-mode t)
 '(sql-postgres-program "/command/psql")
 '(standard-indent 4)
 '(swift-mode:basic-offset 4)
 '(tab-stop-list '(4 8 12 16 24 32 40 48 56 64 72 80 88 96 104 112 120))
 '(tab-width 4)
 '(tide-default-mode "TSX")
 '(tool-bar-mode nil)
 '(tramp-verbose 0)
 '(truncate-lines t)
 '(vc-annotate-background "#93a1a1")
 '(vc-annotate-color-map
   '((20 . "#990A1B") (40 . "#FF6E64") (60 . "#cb4b16") (80 . "#7B6000")
     (100 . "#b58900") (120 . "#DEB542") (140 . "#546E00")
     (160 . "#859900") (180 . "#B4C342") (200 . "#3F4D91")
     (220 . "#6c71c4") (240 . "#9EA0E5") (260 . "#2aa198")
     (280 . "#69CABF") (300 . "#00629D") (320 . "#268bd2")
     (340 . "#69B7F0") (360 . "#d33682")))
 '(vc-annotate-very-old-color "#93115C")
 '(vterm-ignore-blink-cursor nil)
 '(vterm-max-scrollback 5000)
 '(web-mode-attr-indent-offset 2)
 '(web-mode-code-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(web-mode-sql-indent-offset 2)
 '(weechat-color-list
   '(unspecified "#011627" "#010F1D" "#DC2E29" "#EF5350" "#D76443"
                 "#F78C6C" "#D8C15E" "#FFEB95" "#5B8FFF" "#82AAFF"
                 "#AB69D7" "#C792EA" "#AFEFE2" "#7FDBCA" "#D6DEEB"
                 "#FFFFFF")))
(put 'ido-exit-minibuffer 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(setq ansi-term-color-vector
      [term term-color-black term-color-red term-color-green term-color-yellow 
            term-color-blue term-color-magenta term-color-cyan term-color-white])
