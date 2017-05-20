;;; Personal Config --- Personal configuration within Emacs Prelude

;;; Commentary:

;;; Code:

;; Start emacs in fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; add clj-refactor
(prelude-require-packages '(clj-refactor))
(eval-after-load 'clojure-mode
  '(progn
     (defun clojure-mode-clj-refactor-hook ()
       (clj-refactor-mode 1)
       (yas-minor-mode 1) ; for adding require/use/import
       ;; This choice of keybinding leaves cider-macroexpand-1 ("C-c C-m") unbound
       (cljr-add-keybindings-with-prefix "C-c C-r"))

     (add-hook 'clojure-mode-hook #'clojure-mode-clj-refactor-hook)))

;; CIDER cljs repl setup
(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

;; change eshell prompt to have format 'user@host $' on non-windows machines
(unless (eq system-type 'windows-nt)
  (setq eshell-prompt-function
        (lambda ()
          (concat (getenv "USER") "@"
                  (car (split-string (getenv "HOSTNAME") "[.]"))
                  (if (= (user-uid) 0) " # " " $ ")))))

;; Ediff settings
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(provide 'personal-config)
;;; personal-config.el ends here


;;; things to try later

;; anthony's use-package seup
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("org" . "http://orgmode.org/elpa/"))

;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))

;; (require 'use-package)

;; anthony's clojure setup
;;;; clojure setup

;; (use-package clojure-mode
;;     :ensure t)

;; (use-package cider
;;     :ensure t
;;     :config (progn
;;               (add-hook 'clojure-mode-hook 'paredit-mode)
;;               (add-hook 'clojure-mode-hook 'eldoc-mode)
;;               (add-hook 'cider-repl-mode-hook 'paredit-mode)
;;               (add-hook 'cider-mode-hook 'paredit-mode)
;;               (add-hook 'cider-repl-mode-hook 'eldoc-mode)
;;               (add-hook 'cider-mode-hook 'eldoc-mode)
;;               (setq-default cider-repl-history-file "~/.emacs.d/.cider-history")
;;               (setq-default nrepl-prompt-to-kill-server-buffer-on-quit nil)))

;; (add-hook 'clojure-mode-hook (lambda ()
;;                                (dolist (f '(try-expand-line try-expand-list))
;;                                  (setq hippie-expand-try-functions-list
;;                                        (remq f hippie-expand-try-functions-list)))))

;; (use-package flycheck-clojure
;;     :ensure t)

;; (defun my-clojure-mode-hook ()
;;     (clj-refactor-mode 1)
;;     (yas-minor-mode 1) ; for adding require/use/import statements
;; ;; This choice of keybinding leaves cider-macroexpand-1 unbound
;;     (cljr-add-keybindings-with-prefix "C-c c"))

;; (use-package clj-refactor
;;     :ensure t
;;     :config (progn
;;               (add-hook 'clojure-mode-hook 'clj-refactor-mode)
;;               (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)))
