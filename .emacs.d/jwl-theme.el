(deftheme jwl
  "Created 2012-05-09.")

(custom-theme-set-variables
 'jwl
 '(c-basic-offset 4)
 '(explicit-shell-file-name nil)
 '(face-font-family-alternatives (quote (("courier" "fixed") ("helv" "helvetica" "arial" "fixed"))))
 '(hippie-expand-try-functions-list (quote (try-expand-all-abbrevs try-expand-list try-expand-line try-expand-dabbrev try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-complete-lisp-symbol-partially try-complete-lisp-symbol)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(large-file-warning-threshold nil)
 '(minibuffer-auto-raise t)
 '(minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))
 '(ns-alternate-modifier (quote meta))
 '(ns-command-modifier (quote meta))
 '(outline-regexp " *////+")
 '(perl-indent-level 4)
 '(safe-local-variable-values (quote ((encoding . utf-8) (Syntax . Scheme) (Package . Scheme))))
 '(shell-popd-regexp "\\-")
 '(shell-prompt-pattern "^[^#$%>
]*[#$%>] *")
 '(shell-pushd-regexp "pushd")
 '(standard-indent 4)
 '(tab-width 8)
 '(tramp-verbose 0)
 '(truncate-lines t)
 '(user-mail-address "james@coptix.com"))

(provide-theme 'jwl)
