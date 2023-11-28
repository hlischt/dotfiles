(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(age writegood-mode artbollocks-mode gnuplot todotxt ledger-mode sml-mode paredit geiser-guile editorconfig web-mode js2-mode lsp-ui lsp-mode company flycheck which-key dumb-jump elpher nov go-mode markdown-mode org-static-blog draft-mode spray haskell-mode json-mode wanderlust elfeed imenu-list smex counsel ivy olivetti fountain-mode god-mode org-link-minor-mode use-package))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:weight light :family "Fira Sans")))))

(if (string-equal system-type "windows-nt")
    (progn
      (cd (concat (getenv "HOMEDRIVE") (getenv "HOMEPATH")))
      (setq explicit-shell-file-name (concat (getenv "HOMEDRIVE")
					   (getenv "HOMEPATH")
					   "/bin/sh.exe"))
    )
  )

;; Interfaz
(set-language-environment "UTF-8")
(load-theme 'tango-dark)
;; Why does Terminus render so small??
(when (member "Terminus (TTF)" (font-family-list))
  (set-frame-font "Terminus (TTF)-11" t t))
(when (member "Konatu Tohaba" (font-family-list))
  (set-fontset-font "fontset-default" 'kana "Konatu Tohaba"))
(when (member "WenQuanYi Bitmap Song" (font-family-list))
  (set-fontset-font "fontset-default" 'han "WenQuanYi Bitmap Song"))
(when (member "Blobmoji" (font-family-list))
  (set-fontset-font "fontset-default" 'symbol "Blobmoji"))
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq-default frame-title-format '("%b - " invocation-name))
(if (string-equal system-type "windows-nt")
    (scroll-bar-mode -1))
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-auto-revert-mode 1) ; Update buffers if their associated file changes
(global-font-lock-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(global-eldoc-mode -1) ; Getting eldoc errors in non-emacs-lisp files
(setq display-line-numbers-type 'relative)
(delete-selection-mode 1)
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq-default indent-tabs-mode t)
(setq-default tab-width 8)
(setq-default indent-tabs-mode 'only)
(setq echo-keystrokes 0.1)
(setq backward-delete-char-untabify-method 'nil)
(setq mouse-autoselect-window t)
(add-hook 'sh-mode-hook (lambda () (setq sh-basic-offset 8 indent-tabs-mode t)))
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'sgml-basic-offset 'tab-width)
(defvaralias 'css-basic-offset 'tab-width)
(require 'iso-transl)


(fringe-mode 0)
(toggle-word-wrap 1)


(setq default-frame-alist '((font . "Terminus (TTF)-11")
			    (left-fringe . 0)
			    (right-fringe . 0)))

;; Highlight current line
(require 'hl-line)
(set-face-background hl-line-face "gray18" )
(set-face-foreground 'highlight nil)
(global-hl-line-mode 1)

(setq make-backup-files nil) ; Dejar de crear respaldos
;; (setq browse-url-browser-function 'browse-url-firefox)

;; Teclas
(windmove-default-keybindings 'meta)
(define-key key-translation-map (kbd "<apps>") (kbd "<menu>"))

(defun insert-quotes (&optional arg)
  "Enclose following ARG sexps in quotes.
Leave point after open-quote."
  (interactive "*P")
  (insert-pair arg ?\" ?\"))

(defun insert-tab-char ()
  "Insert a tab char. (ASCII 9, \t)"
  (interactive)
  (insert "\t"))

(defun my-delete-word (arg)
  "Kill characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-kill-buffer-filename ()
  "Kill filename associated with the buffer.
It should copy the the buffer file's path to the clipboard."
  (interactive)
  (progn (kill-new buffer-file-name)
	 (message (concat "Copied \"" buffer-file-name "\""))))

(global-set-key (kbd "<C-delete>") 'my-delete-word)
(global-set-key (kbd "<C-backspace>") 'my-backward-delete-word)

(global-set-key (kbd "M-\"") 'insert-quotes)
(global-set-key (kbd "M-_") 'insert-char)

(global-unset-key (kbd "TAB"))
(global-unset-key (kbd "C-p"))
(global-unset-key (kbd "C-n"))
(global-unset-key (kbd "C-f"))
(global-unset-key (kbd "C-b"))
(global-unset-key (kbd "<menu>"))
(global-unset-key (kbd "<f1>"))
(global-unset-key (kbd "<f2>"))
(global-unset-key (kbd "<f3>"))
(global-unset-key (kbd "<f4>"))


(global-set-key (kbd "TAB") 'insert-tab-char)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-:") 'replace-regexp)
(global-set-key (kbd "C-b C-b C-v") 'split-window-below)
(global-set-key (kbd "C-b C-b C-h") 'split-window-right)
(global-set-key (kbd "C-x %") 'split-window-below)
(global-set-key (kbd "C-x \"") 'split-window-right)
(global-set-key (kbd "C-x M-w") 'my-kill-buffer-filename) ; Copy buffer filename
(global-set-key (kbd "<menu>") 'counsel-M-x)
(global-set-key (kbd "<f1>") 'find-file)
(global-set-key (kbd "<f2>") 'save-buffer)
(global-set-key (kbd "<f3>") 'switch-to-buffer)
(global-set-key (kbd "<f4>") 'kill-buffer)
(global-set-key (kbd "<f5>") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<f6>") 'kmacro-end-or-call-macro)


;; Info
(progn
  (require 'info)
  (define-key Info-mode-map (kbd "N") 'Info-prev))

;; Paquetes
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"    . "https://orgmode.org/elpa/")
                         ("gnu"    . "https://elpa.gnu.org/packages/")
                         ("melpa"  . "https://melpa.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; If there are no pkgs, refresh the contents
(unless package-archive-contents
  (package-refresh-contents))
;; and install the packages listed above in package-selected-packages
(package-install-selected-packages)

(require 'fountain-mode)

;; No line wrap on eww
(eval-after-load 'shr
  '(progn (setq shr-width -1)
          (defun shr-fill-text (text) text)
          (defun shr-fill-lines (start end) nil)
          (defun shr-fill-line () nil)))

;; Default modes
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Python mode hook
(add-hook 'python-mode-hook
          '(lambda ()
             ;(seq python-check-command nil)
	     (local-set-key (kbd "<C-backspace>")
			    'my-backward-delete-word)))

;; Go mode hook
(defun my-go-mode-hook ()
  "Custom hook for go-mode."
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(add-hook 'prog-mode-hook
	  '(lambda ()
	     (display-line-numbers-mode)
	     (flycheck-mode)
	     (flycheck-set-indication-mode 'left-margin)))
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; Gnuplot mode hook
(defun my-gnuplot-get-pdf-output ()
  "Return nil or the name of the pdf output.

Search for a line like =set output \"filename.pdf\"=
and return filename.pdf, or nil if nothing was found.
Not safe for names with quotes in them (why would you?)"
    (let ((p (point)) (regex "^set output \"\\(.*\\.pdf\\)\"$"))
	(goto-char (point-min))
	(if (re-search-forward regex nil t)
	    (progn (goto-char p)
		(match-string-no-properties 1))
	  (goto-char p) nil)))

(defun my-gnuplot-run-buffer-file ()
  "Run gnuplot with the file associated with the buffer as argument.
That is, run =gnuplot my_file.gnu= if run on the buffer my_file.gnu.
Runs synchronously, and returns the status code of the finished process."
  (let ((default-directory (file-name-directory buffer-file-name)))
    (call-process "gnuplot" nil "*mupdf-gnuplot output*" t
		  (file-name-nondirectory buffer-file-name))))

(defun my-gnuplot-refresh-or-open-mupdf (pdf-file)
  "Either opens PDF-FILE or sends SIGHUP to mupdf-gnuplot, refreshing it."
  (let ((mupdf-process (get-process "mupdf-gnuplot")))
      (if mupdf-process
	  (signal-process mupdf-process 'HUP)
	(start-process "mupdf-gnuplot" "*mupdf-gnuplot output*"
		       "mupdf" (concat (file-name-directory buffer-file-name)
				       pdf-file)))))

(defun my-gnuplot-pdf-save-hook ()
  "Open or refresh the pdf-output every time the file is saved."
  (if (= (my-gnuplot-run-buffer-file) 0)
      (let ((pdf (my-gnuplot-get-pdf-output)))
	(if pdf (my-gnuplot-refresh-or-open-mupdf pdf) nil))
    (display-warning 'mupdf-gnuplot
		     "Compilation failed. See *mupdf-gnuplot* for more info."
		     :error)))

(defun my-gnuplot-mode-hook ()
  "Custom hook for gnuplot-mode."
  (add-hook 'after-save-hook 'my-gnuplot-pdf-save-hook))
(add-hook 'gnuplot-mode-hook 'my-gnuplot-mode-hook)

;; Editorconfig minor mode
(require 'editorconfig)
(editorconfig-mode 1)

;; dumb-jump/xref hook
(require 'dumb-jump)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; Which key
(require 'which-key)
(setq which-key-idle-delay 0.1)
(which-key-mode)

;; LSP mode
(setq lsp-keymap-prefix "M-p")
(add-hook 'lsp-mode-hook
	  '(lambda ()
	     (let ((lsp-keymap-prefix "M-p"))
	       (lsp-enable-which-key-integration))))
;; olivetti
(require 'olivetti)
(setq olivetti-body-width 80)

;; Ivy Mode
(require 'ivy)
(require 'swiper)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x") 'counsel-M-x)

;; ;; smex
;; (require 'smex)
;; ;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; God Mode
(require 'god-mode)
(global-set-key (kbd "<escape>") 'god-mode-all)

;; Org Mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(setq org-startup-truncated nil)
(setq org-startup-indented t)
(setq org-adapt-indentation nil)
(add-hook 'org-mode-hook #'toggle-word-wrap)
