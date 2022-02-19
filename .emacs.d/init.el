(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(package-selected-packages
   '(org-static-blog draft-mode spray haskell-mode json-mode wanderlust elfeed imenu-list smex counsel ivy olivetti fountain-mode god-mode org-link-minor-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(variable-pitch ((t (:weight semi-light :family "Fira Sans")))))

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
(when (member "Terminus" (font-family-list))
  (set-frame-font "Terminus-11" t t))
(when (member "Konatu Tohaba" (font-family-list))
  (set-fontset-font "fontset-default" 'kana "Konatu Tohaba"))
(when (member "WenQuanYi Bitmap Song" (font-family-list))
  (set-fontset-font "fontset-default" 'han "WenQuanYi Bitmap Song"))
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
(setq-default frame-title-format '("%b - " invocation-name))
(if (string-equal system-type "windows-nt")
    (scroll-bar-mode -1))
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-auto-revert-mode 1)
(global-font-lock-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
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


(setq default-frame-alist '((font . "Terminus-11")
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
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

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
(setq package-archives '(("org"   . "https://orgmode.org/elpa/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
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

;; Python mode hook
(add-hook 'python-mode-hook
          '(lambda ()
             ;(seq python-check-command nil)
	     (local-set-key (kbd "<C-backspace>")
			    'my-backward-delete-word)))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

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
