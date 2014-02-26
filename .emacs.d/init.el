;言語及び文字コード
(set-language-environment "Japanese")
(setq buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'sjis-mac)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(when (eq file-name-coding-system nil) (set-file-name-coding-system 'utf-8))
(global-font-lock-mode t)

;Localeに合わせた環境設定
(set-locale-environment nil)

;Mac
(setq default-input-method "MacOSX")
(setq mac-option-modifier 'meta)

;Shell Mode
(setq shell-file-name "/bin/zsh")


;フォント設定
;(set-face-attribute 'default nil
;                   :family "Ricty"
;                   :height 140)
;(set-fontset-font "Ricty"
; nil 'japanese-jisx0208
; (font-spec :family "Ricty"))


;ロードパス
(setq load-path (append
		 '("~/.emacs.d/site-lisp"
		   "~/.emacs.d/site-lisp/yatex"
		   "~/.emacs.d/site-lisp/haskell"
		   "~/.emacs.d/site-lisp/scala-mode"
           "~/.emacs.d/site-lisp/Highlight-Indentation-for-Emacs")
		 load-path))

;実行パス
;(add-to-list 'exec-path "/usr/local/bin")
;(setenv "PATH" (concat (getenv "PATH") ";/usr/local/bin"))

;キーバインド
(define-key global-map (kbd "C-h") 'delete-backward-char) ;バックスペース
(define-key global-map (kbd "C-z") 'undo) ;undo
(define-key global-map (kbd "C-c i") 'indent-region) ;インデント
(define-key global-map (kbd "C-c C-i") 'hippie-expand) ;補完


;ファイル末の改行がなければ追加
(setq require-final-newline t)

;括弧の協調
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "red")
(set-face-foreground 'show-paren-match-face "SkyBlue")

;情報バーに行番号と桁表示
(column-number-mode t)
(line-number-mode t)

;日時の表示
(display-time)

;起動時のメッセージ非表示
(setq inhibit-startup-message t)

;"yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;カーソル移動を論理行から物理行に
;(require 'physical-line)
;(setq-default physical-line-mode t)
;dired-modeは論理行のまま
;(setq physical-line-ignoring-mode-list '(dired-mode))

;選択範囲に色付け
(setq transient-mark-mode t)

;行末の空白を表示
(setq-default show-trailing-whitespace t)

;タブでの補完をスペースに
(setq-default tab-width 4 indent-tabs-mode nil)

;EOB表示
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;メニューバーを消す
;(if (not window-system)
;    (menu-bar-mode -1))
(menu-bar-mode -1)

; highlight-indentation
(require 'highlight-indentation)
(setq highlight-indentation-offset 4)  ;; default: 4
(set-face-background 'highlight-indentation-face "#e3e3d3")
(set-face-background 'highlight-indentation-current-column-face "#e3e3d3")

;; highlight-indentation-mode が呼ばれたら highlight-indentation-current-column-mode も実行する
(add-hook 'highlight-indentation-mode-hook 'highlight-indentation-current-column-mode)
 
;; 各種モードで highlight-indentation-mode が実行されるようにする
;(add-hook 'Yatex 'highlight-indentation-mode)

; 現在の行をハイライトする
; vline.el と依存関係あり
; 常にハイライト
; (column-highlight-mode 1)
; 5秒間放置でハイライト
; (toggle-highlight-column-when-idle 1)
; (col-highlight-set-interval 6)
(require 'col-highlight)
;(column-highlight-mode 1)
(toggle-highlight-column-when-idle 1)
(col-highlight-set-interval 6)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       wb-line-number                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'wb-line-number)
(wb-line-number-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           YaTeX                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
;; ((not *ms-windows-p*)
;;       (setq YaTeX-hilit-sectioning-face '(darkred/snow snow/darkred))))
;; font 関連は require の前に？
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(setq YaTeX-use-font-lock (featurep 'font-lock)
;      YaTeX-use-hilit19 nil
;      tex-command  "platex"
;      dvi2-command "xdvi"
;      ;; kanji-code 1: SJIS, 2: JIS, 3: EUC
;      YaTeX-kanji-code  2
;      YaTeX-use-LaTeX2e t
;      YaTeX-user-completion-table "~/.emacs.d/.yatexrc"
;      YaTeX-help-file             (concat *site-lisp* "yatex1.70/help/YATEXHLP.jp")
;      YaTeX-help-file-private     "~/.emacs.d/YATEXHLP.jp")
(add-hook 'yatex-mode-hook'(lambda ()(setq auto-fill-function nil)))
(setq dvi2-command "xdvi"
      tex-command "platex"
      dviprint-command-format "dvips %s | lpr"
      YaTeX-kanji-code 4)
(defun tex-imenu-create-index ()
  (let (index)
    (goto-char (point-min))
    (while (re-search-forward "^\\\\\\(chapter\\|.*section\\|.*paragraph\\){\\(.+\\)}" (point-max) t)
      (push (cons (concat (concat (match-string 1) "\t:") (match-string 2)) (match-beginning 2)) index))
    (nreverse index)))
(add-hook 'yatex-mode-hook
	    '(lambda ()
	            (setq imenu-create-index-function 'tex-imenu-create-index)))

;; bibtexのエンジンをpbibtexに
(setq bibtex-command (cond ((string-match "uplatex" tex-command) "upbibtex")
                           ((string-match "platex" tex-command) "pbibtex -kanji=utf8")
                           ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "bibtexu")
                           (t "bibtex")))
(setq bibtex-command "pbibtex -kanji=utf8")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           YaHtml-mode                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (cons (cons "\\.html$" 'html-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;       (cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
;; (autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
;; (setq yahtml-www-browser "netscape")


;; anythin系設定
;(require 'anything-startup)
;(require 'anything)
;(require 'anything-config)
;(require 'anything-match-plugin)
;(require 'anything-gtags)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Haskell                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(nconc auto-mode-alist
       '(("\\.[hg]s$"  . haskell-mode)
	   ("\\.hi$"     . haskell-mode)
	      ("\\.l[hg]s$" . literate-haskell-mode)))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          Python                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(nconc auto-mode-alist '(("\\.py\\w?" . python-mode)))
;(autoload 'python-mode "python-mode" "Major mode for editing python code" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          scala-mode                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elispを溜め込んでいるディレクトリが ~/lisp
;; scalaはHome brewでインストール
;; scala-mode
(require 'scala-mode-auto)
(setq scala-interpreter "/usr/local/bin/scala")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        xml-xpath-apply                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xml-xpath-apply ()
(interactive)
(let ((now-window (selected-window))
(xpath (read-string "XPath: " ""))
(file-name (buffer-file-name)))
(save-buffer)
(pop-to-buffer (get-buffer-create "*XPath Result*"))
(erase-buffer)
(insert "XPath: ")
(insert xpath)
(insert "\n")
(insert (concat "xpath " file-name " " xpath))
(insert "\n\n")
(insert (shell-command-to-string (concat "xpath " file-name " " (shell-quote-argument xpath))))
(select-window now-window)))

;;; ispell ;;;
(setq-default ispell-program-name "/usr/local/bin/aspell")
