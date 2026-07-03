
;; Basic config stuff, define root library path

(defvar lib-root "~/.emacs.d/james/lib/")
(add-to-list 'load-path lib-root)

(defun jwl-add-path (path)
  (add-to-list 'load-path (concat lib-root path)))

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setenv "PATH" (concat "/Users/james/.nvm/versions/node/v20.19.4/bin:" (getenv "PATH")))
(setenv "PATH" (concat "/Users/james/Library/pnpm:" (getenv "PATH")))
(setenv "PATH" (concat "/Users/james/.bun/bin:" (getenv "PATH")))

(setq exec-path (cons "/usr/local/bin" exec-path))
(setq exec-path (cons "/Users/james/.nvm/versions/node/v20.19.4/bin" exec-path))

;; scrolling

(setq scroll-step 1 scroll-conservatively  10000)
;; (set-face-attribute 'default nil :height 150)

;; Configure how and where backups of files are stored

(defun jwl-backups (backup)
  "Set all the variables to move backups & autosave files out of
the working directory"
  (let ((backup (if (eql "/" (aref backup (- (length backup) 1)))
                    backup
                  (concat backup "/"))))
    (make-directory backup t)
    (setq backup-by-copying t
          delete-old-versions t
          kept-new-versions 10
          kept-old-versions 1
          version-control t
          backup-directory-alist `(("." . ,backup))
          tramp-backup-directory-alist backup-directory-alist)))

(jwl-backups "~/.emacs.d/backup")

;; Configure where and how autosaving files are stored 
;; (inspired from http://snarfed.org/space/gnu+emacs+backup+files)

(defvar autosave-dir nil)

(defun jwl-autosave (dir)
  (setq autosave-dir dir)
  (make-directory autosave-dir t)
  (setq auto-save-default t))

(setq auto-save-default nil)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (replace-regexp-in-string "/" "!" buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))

(jwl-autosave "~/.emacs.d/autosaves/")

;; Misc minor customizations

;; (fset 'yes-or-no-p 'y-or-n-p)
(put 'set-goal-column 'disabled nil)
;; (column-number-mode t)
(add-hook 'before-save-hook 'time-stamp)
;; (show-paren-mode +1)
(savehist-mode 1)
(delete-selection-mode +1)

;; Fix OS X keys

;;(global-set-key "\M-`" 'other-frame)
;; (global-set-key "\M-h" 'ns-do-hide-emacs)
(setq ns-pop-up-frames nil)
