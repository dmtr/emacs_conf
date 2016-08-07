(add-to-list 'load-path "~/.emacs.d/lisp")

(load "package")
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa.org/packages/")))

(add-to-list 'package-archives
	                  '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)


(package-initialize)
(elpy-enable)

;; modes
;;(require 'uniquify)
;;(require 'ido)
;;(ido-mode t)
;;
(require 'evil)
(evil-mode 1)
(evil-set-initial-state 'term-mode 'emacs)

(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
(helm-adaptive-mode 1)
(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

(add-hook 'after-init-hook 'global-company-mode)
;;(add-hook 'after-save-hook 'elpy-check)
(add-hook 'python-mode-hook 
          (lambda () 
             (add-hook 'after-save-hook 'elpy-check nil 'make-it-local)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes (quote ("20e3ac09eec890c4e8d79f4889fb0db20568dafbdccb32f46d948b2cfde05339" "6dc966f17065aa2f0a7111776e016eebf5bd06c50c673bbe0d9e3a4604ac288a" default)))
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 168 :width normal :foundry "unknown" :family "Ubuntu Mono")))))

(global-linum-mode t)
;;(global-set-key [(control-x s)] 'occur)
;;(global-set-key [(control f6)] 'rgrep)
;;(global-set-key "\M-a" 'hippie-expand)
;;(global-set-key [(control shift f)] 'find-name-dired)

;;(autoload 'idomenu "idomenu" nil t)

;;Python
(global-set-key "\M-g" 'elpy-goto-definition)
(global-set-key "\M-b" 'pop-tag-mark)
(setenv "LC_CTYPE" "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")

;; add pylookup to your loadpath, ex) ~/.emacs.d/pylookup
(setq pylookup-dir "/Users/dmtr/github/pylookup")
(add-to-list 'load-path pylookup-dir)

;; load pylookup when compile time
(eval-when-compile (require 'pylookup))

;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

;; set search option if you want
;; (setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)
(global-set-key (kbd "C-c p s") 'pylookup-lookup)
