;; Let other things read what I'm doing

(server-start)

;; magit

(defun jwl-magit-read-worktree-directory (prompt branch)
  "Read a sibling worktree directory for the current project."
  (let* ((project-directory (magit-toplevel))
         (project-name (file-name-nondirectory
                        (directory-file-name project-directory)))
         (worktrees-directory
          (expand-file-name (concat project-name "-worktrees")
                            (file-name-directory
                             (directory-file-name project-directory))))
         (worktree-name (read-string prompt
                                     (and branch
                                          (string-replace "/" "-" branch)))))
    (mkdir worktrees-directory t)
    (expand-file-name worktree-name worktrees-directory)))

(with-eval-after-load 'magit-worktree
  (setq magit-read-worktree-directory-function
        #'jwl-magit-read-worktree-directory))

;; reverting

(global-auto-revert-mode)
(setq auto-revert-verbose nil)

;; claude code

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

(defun opencode-start ()
  (interactive)
  (require 'claude-code-ide)
  (let ((port (claude-code-ide-mcp-start (claude-code-ide--get-working-directory))))
    (message "opencode port: %s" port)
    port))

;; tide

(require 'flycheck)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)
(add-hook 'tsx-ts-mode-hook #'setup-tide-mode)

;; Clears out all the existing errors when restarting
(advice-add 'tide-restart-server :before (lambda (&rest _) (flycheck-clear)))

;; This forces a new typecheck once the server comes up
(advice-add 'tide-restart-server :after (lambda (&rest _) (flycheck-mode +1)))

(with-eval-after-load 'tide
  (define-key tide-mode-map (kbd "C-h .") 'tide-documentation-at-point)
  (flycheck-add-mode 'typescript-tide 'tsx-ts-mode))

(setq company-tooltip-align-annotations t)

;; auto-complete

(require 'auto-complete)
(global-auto-complete-mode t)

;; merlin (ocaml)

;; (jwl-add-path "merlin/emacs")
;; (setq merlin-command "/Users/james/.opam/4.02.3/bin/ocamlmerlin")
;; (setenv "OCAMLFIND_CONF" "/Users/james/.opam/4.02.3/lib/findlib.conf")
;; (autoload 'merlin-mode "merlin" "Merlin mode" t)

;; reason

;; (jwl-add-path "reason")
;; (setq refmt-command "/Users/james/.opam/4.02.3/bin/refmt")
;; (require 'reason-mode)
;; (add-hook 'reason-mode-hook
;;          (lambda ()
;;            (add-hook 'before-save-hook 'refmt-before-save)
            ;; (merlin-mode)
;;            ))

;; keynote code highlighting

(defun keynote-highlight ()
  (interactive)
  (shell-command-on-region
   (region-beginning)
   (region-end)
   "highlight -O rtf --font-size 36 --font Inconsolata --style solarized-dark -W -J 50 -j 3 --src-lang ruby | pbcopy"))


;; demo scrolling

(defun jwl-scroll-up ()
  (interactive)
  (scroll-down 1))

(defun jwl-scroll-down ()
  (interactive)
  (scroll-up 1))

(global-set-key [(control down)] 'jwl-scroll-down)
(global-set-key [(control up)] 'jwl-scroll-up)

;; javascript

(add-to-list 'auto-mode-alist '("\\.ts$" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(setq js-indent-level 2)
(autoload 'tern-mode "tern.el" nil t)

(require 'prettier-js)
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (add-hook 'before-save-hook 'prettier-before-save)))

(global-set-key
 (kbd "<f9>")
 (lambda ()
   (interactive)
   ;;(run-js "~/projects/mozilla/devrepl/devrepl")
   (run-js "/usr/local/bin/node --harmony")
   ;;(run-js "/usr/local/bin/node /Users/james/projects/v8repl/index.js")
   ))

(defun jwl-flash-region (start end &optional timeout)
  "Temporarily highlight region from START to END."
  (let ((overlay (make-overlay start end))) 
    (overlay-put overlay 'face 'secondary-selection)
    (run-with-timer (or timeout 0.2) nil 'delete-overlay overlay)))

(defun jwl-js-send-defun ()
  (interactive)
  (save-excursion
    (lexical-let ((start (slime-js-start-of-toplevel-form))
                  (end (slime-js-end-of-toplevel-form)))
      (jwl-flash-region start end)
      (js-send-region start end))))

(defun jwl-eslint-from-node-modules ()
  (let ((root (locate-dominating-file (or (buffer-file-name) default-directory) "node_modules")))
    (while root        
      (let ((eslint (expand-file-name "node_modules/eslint/bin/eslint.js" root)))
        (if (and eslint (file-executable-p eslint))
            (progn
              (setq-local flycheck-javascript-eslint-executable eslint)
              (setq root nil))
          (setq root
                (locate-dominating-file (concat root "..") "node_modules")))))))
(add-hook 'flycheck-mode-hook #'jwl-eslint-from-node-modules)
(flycheck-add-mode 'javascript-eslint 'javascript-mode)

;; c/c++

(add-hook 'c++-mode
          (lambda ()
            (setq show-trailing-whitespace t)))
(add-hook 'c-mode
          (lambda ()
            (setq show-trailing-whitespace t)))

;; css

(add-to-list 'auto-mode-alist '("\\.less$" . css-mode))

;; large fringes!

(defun i-am-a-writer ()
    (interactive)
  (setq jwl-margin (/ (- (/ (frame-pixel-width) (frame-char-width)) 70)
                      2))
  (set-window-margins nil jwl-margin jwl-margin)
  (markdown-mode)
  (visual-line-mode))

;; no bell

(setq visible-bell nil)

;; file modes

(add-to-list 'auto-mode-alist '("\\.ol$" . scheme-mode))
(add-to-list 'auto-mode-alist '("\\.vsh$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.fsh$" . c-mode))

;; tramp

;; (add-to-list 'tramp-default-proxies-alist '(".*" "\\`root\\'" "/ssh:%h:"))

;; misc

(remove-hook 'text-mode-hook 'turn-on-auto-fill)
(remove-hook 'text-mode-hook 'turn-on-flyspell)

;; js

;; Copied and tweaked from
;; http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
;; Use the same indentation rules from js-mode
(require 'js)
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (js--proper-indentation parse-status))
           node)

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(setq inferior-js-program-command "/usr/local/bin/node")

(defun jwl-setup-js ()
  (setq show-trailing-whitespace t)

  (font-lock-add-keywords
   nil `(("\\(function *\\)("
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    "ƒ")
                    nil)))))

  ;;(web-mode-set-content-type "jsx")
  (flycheck-mode)
  )

(add-hook 'js-mode-hook 'jwl-setup-js)

(add-to-list 'auto-mode-alist '("\\.jsm$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js-mode))

(setenv "NODE_NO_READLINE" "1")

;; org-mode

(setq org-todo-keywords
      '((sequence "TODO" "WAITING" "ACTIVE" "DONE")))
;; (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-return-follows-link t)

;; turn off line highlighting

(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

;; turn off transient mark mode

(transient-mark-mode nil)

;; abbrevs

(setq default-abbrev-mode t)

;; uniquify

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; winner-mode

(setq winner-dont-bind-my-keys t)
(winner-mode t)

;; Notifications

(defun notify (title message)
  (start-process "terminal-notifier" " terminal-notifier"
                 "terminal-notifier"
                 "-message" message
                 "-title" title
                 ;;"-s"
                 ))

;; SSL

;; (require 'tls)

;; Master keybindings

(defun swap-with (dir)
  (interactive)
  (let ((other-window (if (equalp dir 'next)
                          (next-window (selected-window)
                                       (> (minibuffer-depth) 0))
                        (previous-window (selected-window)
                                         (> (minibuffer-depth) 0)))))
    (when other-window
      (let* ((this-window  (selected-window))
             (this-buffer  (window-buffer this-window))
             (other-buffer (window-buffer other-window))
             (this-start   (window-start this-window))
             (other-start  (window-start other-window)))
        (set-window-buffer this-window  other-buffer)
        (set-window-buffer other-window this-buffer)
        (set-window-start  this-window  other-start)
        (set-window-start  other-window this-start)
        (select-window other-window)
        (select-frame-set-input-focus (selected-frame))))))

(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map "\M-j" 
  (lambda () (interactive) (select-window (next-window))))
(define-key my-keys-minor-mode-map "\M-k"
  (lambda () (interactive) (select-window (previous-window))))

(define-key my-keys-minor-mode-map "\M-J"
  (lambda ()
    (interactive)
    (swap-with 'next)))

(define-key my-keys-minor-mode-map "\M-K"
  (lambda ()
    (interactive)
    (swap-with 'prev)))

(define-key my-keys-minor-mode-map "\M-i"
  (lambda () (interactive) (fzf-git)))

(define-key my-keys-minor-mode-map
  (kbd "M-RET")
  (lambda ()
    (interactive)
    (if (eq (length (window-list)) 1)
        (let ((p (point)))
          (jump-to-register ?W)
          (goto-char p))
      (progn
        (window-configuration-to-register ?W)
        (delete-other-windows)))))

(defun buffer-point-map ()
  (save-excursion
    (mapcar (lambda (buffer) (cons (buffer-name buffer)
                                   (progn (set-buffer buffer) (point))))
            (buffer-list))))

(defun apply-buffer-points (buff-point-map)
  (mapc (lambda (window) (let* ((buffer (window-buffer window))
                                (buffer-point (cdr (assoc (buffer-name buffer) buff-point-map))))
                           (when buffer-point (set-window-point window buffer-point))))
        (window-list))
  nil)

(defvar workspaces-list nil)
(defvar workspaces-are-initialized nil)

(defun workspace-create-new (deskid)
  "Create a blank workspace at id deskid, between 1 and 9"
  (interactive "cWhat ID do you want to give to blank workspace ?")
  (workspace-goto ?0)
  (window-configuration-to-register deskid)
  (add-to-list 'workspaces-list deskid)
  (workspace-goto deskid))

(defun workspace-goto (deskid)
  "Go to another workspace, deskid is workspace number between 1 and 9;
    Workspace 0 is a template workspace, do not use it unless you know what you do;
    You can kill a workspace with 'k' and fallback on 1."
  (interactive "cTo which workspace do you want to go ? ")
  (let (add)
    (setq add (if (eq deskid ?0) "\n!-!-! This is template workspace. New workspaces are based on it. " nil))
    (cond
     ((not (eq deskid ?k))
      (if (or (member deskid workspaces-list) (eq deskid ?0))
    	  (progn
    	    (window-configuration-to-register current-workspace)
    	    (setq current-workspace deskid)

            ;; don't restore all the points as they were, it's more
            ;; useful to keep them (terminal windows still scroll, etc)
            (let ((points (buffer-point-map)))
              (jump-to-register deskid)
              (apply-buffer-points points)))
    	(if (y-or-n-p "This workspace does not exist, should it be created ? ")
    	    (progn
    	      (window-configuration-to-register current-workspace)
    	      (workspace-create-new deskid))
    	  nil)))
     ((and (eq deskid ?k) (not (or (eq current-workspace ?0) (eq current-workspace ?1))))
      (let ((deskid-to-del current-workspace))
    	(workspace-goto ?1)
    	(setq workspaces-list (remove deskid-to-del workspaces-list))))
     (t (setq add "\n Cannot kill workspaces 0 and 1")))
    (message (concat "Workspace " (char-to-string current-workspace) " out of [" (mapconcat 'char-to-string (sort (copy-sequence workspaces-list) '<) ", ") "]" add))))

(unless workspaces-are-initialized
  (window-configuration-to-register ?0)
  (setq current-workspace ?0)
  (workspace-create-new ?1)
  (setq workspaces-are-initialized t))

(define-key my-keys-minor-mode-map (kbd "\C-xd") 'workspace-goto)

(define-key my-keys-minor-mode-map (kbd "M-1")
  (lambda ()
    (interactive)
    (workspace-goto ?1)))
(define-key my-keys-minor-mode-map (kbd "M-2")
  (lambda ()
    (interactive)
    (workspace-goto ?2)))
(define-key my-keys-minor-mode-map (kbd "M-3")
  (lambda ()
    (interactive)
    (workspace-goto ?3)))
(define-key my-keys-minor-mode-map (kbd "M-4")
  (lambda ()
    (interactive)
    (workspace-goto ?4)))
(define-key my-keys-minor-mode-map (kbd "M-5")
  (lambda ()
    (interactive)
    (workspace-goto ?5)))

(define-key my-keys-minor-mode-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(define-key my-keys-minor-mode-map (kbd "M-ESC") 'ido-switch-buffer)
(define-key my-keys-minor-mode-map (kbd "M-`") 'ido-switch-buffer)

(define-key my-keys-minor-mode-map
  (kbd "<f1>")
  (lambda ()
    (interactive)
    (cond
     ((eq major-mode 'term-mode)
      (if (term-in-line-mode)
          (term-char-mode)
        (term-line-mode)))
     (t (evil-mode)))))

(define-key my-keys-minor-mode-map (kbd "M-o") 'find-file)
(define-key my-keys-minor-mode-map (kbd "M-s") 'save-buffer)
;; f3 and f4 define/execute macros
(define-key my-keys-minor-mode-map 
  (kbd "<f6>")
  (lambda () 
    (interactive)
    (kill-buffer (current-buffer))))

(define-key my-keys-minor-mode-map (kbd "<f7>") 'ns-toggle-fullscreen)

(define-key my-keys-minor-mode-map (kbd "M-/") 'auto-complete)

;; (define-key my-keys-minor-mode-map
;;   (kbd "M-[")
;;   'previous-buffer)

;; (define-key my-keys-minor-mode-map
;;   (kbd "M-]") 
;;   'next-buffer)

(define-key my-keys-minor-mode-map (kbd "M-{") 'multi-term-prev)
(define-key my-keys-minor-mode-map (kbd "M-}") 'multi-term-next)

(define-key global-map (kbd "C-o") 'ace-jump-mode)

;; (define-key my-keys-minor-mode-map (kbd "M-p") 'backward-paragraph)
;; (define-key my-keys-minor-mode-map (kbd "M-n") 'forward-paragraph)

;; (define-key my-keys-minor-mode-map (kbd "M-C-<left>") 'winner-undo)
;; (define-key my-keys-minor-mode-map (kbd "C-s-<right>") 'winner-redo)

(define-key my-keys-minor-mode-map (kbd "M-F")
  (lambda ()
    (interactive)
    (prettier)))

;; (set-register ?v '(file . "/sudo::/etc/apache2/extra/httpd-vhosts.conf"))

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

;; term

;;(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(global-set-key (kbd "<f8>") 'multi-term)

;; unicode
(defadvice multi-term (after advise-ansi-term-coding-system)
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-deactivate 'multi-term)

(define-key my-keys-minor-mode-map (kbd "<f8>") 'multi-term)

(setq term-bind-key-alist
      `(("M-d" . term-send-forward-kill-word)
        ("M-DEL" . term-send-backward-kill-word)
        ("M-f" . term-send-forward-word)
        ("M-b" . term-send-backward-word)
        ("M-v" . term-send-raw)
        ("C-c" . term-interrupt-subjob)
        ("C-y" . term-paste)
        ("C-k" . (lambda ()
                   (interactive)
                   (kill-line)
                   (term-send-raw-string "\C-k")))))

(provide 'jwl-emacs)
