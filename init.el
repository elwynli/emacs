
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("e4486d0ad184fb7511e391b6ecb8c4d7e5ab29e2d33bc65403e2315dbacaa4aa" default))
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(cnfonts markdown-mode auto-org-md page-break-lines projectile all-the-icons dashboard which-key rust-mode))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;========================================
;; 打开配置函数
;;========================================
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;;========================================
;; kl-new-line
;;========================================
(defun kl-new-line()
  (interactive)
  (move-end-of-line 1)
  (newline))
  


;;========================================
;; 简写词汇
;;========================================
(setq-default abbrev-mode t)
(read-abbrev-file "~/.emacs.d/.abbrev_defs")
(setq save-abbrevs t)


;;========================================
;; 备份
;;========================================
(setq
  backup-by-copying t           ; 自动备份
  backup-directory-alist
  '(("." . "~/.emacs.d/.saves")); 自动备份在目录"~/.emacs.d/.saves"下
  delete-old-versions t         ; 自动删除旧的备份文件
  kept-new-versions 10          ; 保留最近的6个备份文件
  kept-old-versions 3           ; 保留最早的2个备份文件
  version-control t)            ; 多次备份

 
;;===========================================================================
;; 垃圾回收，在 Windows Emacs 25 版本会频繁触发垃圾回收，以下解决此问题
;;===========================================================================
;;(when (eq system-type 'windows-nt)
;;  (setq gc-cons-threshold (* 512 1024 1024))
;;  (setq gc-cons-percentage 0.5)
;;  (run-with-idle-timer 5 t #'garbage-collect)
;;  ;; (setq garbage-collection-messages t)  ; 调试垃圾回收信息
;;)


;;========================================
;; encoding
;;========================================
(set-language-environment 'Chinese-GBK)
;; (prefer-coding-system 'gb18030)
(prefer-coding-system 'utf-8-auto)

;; (setq locale-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-default buffer-file-coding-system 'utf8)
;; (set-default-coding-systems 'utf-8)
;; ;; (set-clipboard-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (modify-coding-system-alist 'process "*" 'utf-8)
;; (setq default-process-coding-system '(utf-8 . utf-8))
;; (setq-default pathname-coding-system 'utf-8)
;; (set-file-name-coding-system 'utf-8)
;; (defun change-shell-mode-coding ())


;;========================================
;; UI
;;========================================
(server-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq cursor-type 'bar)
(icomplete-mode 1)
(global-auto-revert-mode 1)
;;;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;;(set-face-attribute 'default nil :height 160)
;;;; Window Size
;;(set-frame-font "Megatops ProCoder 1.0")
(if (not (eq window-system nil))
  (progn
    ;; top, left ... must be integer
    (add-to-list 'default-frame-alist
      (cons 'top  (/ (x-display-pixel-height) 10)))
    (add-to-list 'default-frame-alist
      (cons 'left (/ (x-display-pixel-width) 10)))
    (add-to-list 'default-frame-alist
      (cons 'height (/ (* 4 (x-display-pixel-height))
                       (* 5 (frame-char-height)))))
    (add-to-list 'default-frame-alist
      (cons 'width (/ (* 4 (x-display-pixel-width))
                      (* 5 (frame-char-width)))))))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

(desktop-save-mode 1)
(save-place-mode 1)


;;========================================
;; package
;;========================================

;;(push "~/.emacs.d/lisp" load-path)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(setq default-directory "d:/code/emacs/")
(setq command-line-default-directory "d:/code/emacs/")


(add-to-list 'load-path "~/.emacs.d/kl-settings/")
(require 'nodesktopsaveorsessionwarning)
;; (require 'google)
;; (setq google-license-key "" ; optional
;;       google-referer "https://www.google.com") ; required!
;; (google-search-video "rickroll")


(require 'cnfonts)
;; 让 cnfonts 在 Emacs 启动时自动生效。
(cnfonts-mode 1)
;; 添加两个字号增大缩小的快捷键
(define-key cnfonts-mode-map (kbd "C--") #'cnfonts-decrease-fontsize)
(define-key cnfonts-mode-map (kbd "C-=") #'cnfonts-increase-fontsize)


;; (use-package all-the-icons
;;   :ensure t)

;;========================================
;; neotree
;;========================================

;; (when (display-graphic-p)
;;   (require 'all-the-icons))
;; or
(use-package all-the-icons
  :if (display-graphic-p))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))



;;========================================
;; dashboard 会拖慢
;;========================================
(require 'dashboard)
(dashboard-setup-startup-hook) 

(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard"
      dashboard-startup-banner 'official
      dashboard-center-content t
      dashboard-show-shortcuts nil
      dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5))
      dashboard-set-heading-icons t
      dashboard-set-file-icons t
      dashboard-set-navigator t)
(dashboard-modify-heading-icons '((recent . "file-text")
				  (bookmarks . "book")))

(page-break-lines-mode)

(projectile-mode +1)
;; Recommended keymap prefix on macOS
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;;========================================
;; Complete Any
;;========================================
;(global-company-mode 1)
;(define-key company-active-map (kbd "C-n") 'company-select-next)
;(define-key company-active-map (kbd "C-p") 'company-select-previous)


;;========================================
;; 插入时间日期
;;========================================
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func. See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func. Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer. Uses `current-date-time-format' for the formatting the date/time."
  (interactive)
  (insert "==========\n")
  ;; (insert (let () (comment-start)))
  (insert (format-time-string current-date-time-format (current-time)))
  (insert "\n"))

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n"))


;;=======================================
;; textile-mode
;;=======================================
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))


;;========================================
;; 注释
;;========================================
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
      (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
    (end (line-end-position arg)))
  (copy-region-as-kill beg end)))


(defun copy-word (&optional arg)
  "Copy words at point"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point))) 
    (end (progn (forward-word arg) (point))))
  (copy-region-as-kill beg end)))


(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point))) 
	(end (progn (forward-paragraph arg) (point))))
  (copy-region-as-kill beg end)))


(defun quick-copy-line ()
   "Copy the whole line that point is on and move to the beginning of the next line. Consecutive calls to this command append each line to the kill-ring."
   (interactive)
   (let ((beg (line-beginning-position 1))
         (end (line-beginning-position 2)))
     (if (eq last-command 'quick-copy-line)
	 (kill-append (buffer-substring beg end) (< end beg))
       (kill-new (buffer-substring beg end))))
   (beginning-of-line 2))


(defun quick-cut-line ()
  "Cut the whole line that point is on.  Consecutive calls to this command append each line to the kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
	(end (line-beginning-position 2)))
    (if (eq last-command 'quick-cut-line)
	(kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end)))
    (delete-region beg end))
  (beginning-of-line 1)
  (setq this-command 'quick-cut-line))


;; copy region or whole line
(global-set-key "\M-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-ring-save (region-beginning)
      (region-end))
    (progn
     (kill-ring-save (line-beginning-position)
     (line-end-position))
     (message "copied line")))))


;; kill region or whole line
(global-set-key "\C-w"
(lambda ()
  (interactive)
  (if mark-active
      (kill-region (region-beginning)
   (region-end))
    (progn
     (kill-region (line-beginning-position)
  (line-end-position))
     (message "killed line")))))


(global-set-key (kbd "<f2>") 'open-init-file)
(global-set-key (kbd "<f3>") 'eval-buffer)
(global-set-key (kbd "<f11>") 'quick-copy-line)
(global-set-key (kbd "M-<f11>") 'quick-cut-line)
(global-set-key (kbd "C-c C-d") 'insert-current-date-time)
(global-set-key (kbd "C-c C-t") 'insert-current-time)
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-J") 'kl-new-line)
