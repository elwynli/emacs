
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes nil)
 '(package-selected-packages
   '(page-break-lines projectile all-the-icons dashboard which-key rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Megatops ProCoder 1.0" :foundry "raster" :slant normal :weight normal :height 105 :width normal)))))


;;========================================
;; F2 打开配置；F3 刷新配置
;;========================================
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)
(global-set-key (kbd "<f3>") 'eval-buffer)


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
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; (setq garbage-collection-messages t)  ; 调试垃圾回收信息
)


;;========================================
;; encoding
;;========================================
(set-language-environment 'Chinese-GBK)
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
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)
;; Window Size
(set-frame-font "Megatops ProCoder 1.0")
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


;;========================================
;; package
;;========================================
(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(push "~/.emacs.d/lisp" load-path)
(let ((default-directory  "~/.emacs.d/lisp/")) (normal-top-level-add-subdirs-to-load-path))
(package-initialize)
(setq default-directory "d:/code/emacs/")
(setq command-line-default-directory "d:/code/emacs/")


;;========================================
;; dashboard 因拖慢，已禁用
;;========================================
;; (require 'dashboard)
;; (dashboard-setup-startup-hook) 
;; (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; (setq dashboard-startup-banner 1)
;; (setq dashboard-center-content t)
;; (setq dashboard-show-shortcuts nil)
;; (setq dashboard-items '((recents  . 5)
;;                         (bookmarks . 5)
;;                         (projects . 5)
;;                         (agenda . 5)
;;                         (registers . 5)))
;; (setq dashboard-set-heading-icons t)
;; (setq dashboard-set-file-icons t)

;;========================================
;; neotree
;;========================================
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;;(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;(when (display-graphic-p) require 'all-the-icons))
;;or
;;(use-package all-the-icons :if (display-graphic-p))


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
  ;(insert (let () (comment-start)))
  (insert (format-time-string current-date-time-format (current-time)))
  (insert "\n")
)

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
  (interactive)
  (insert (format-time-string current-time-format (current-time)))
  (insert "\n")
)


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



(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)
(global-set-key "\C-c\C-c" 'comment-or-uncomment-region-or-line)

