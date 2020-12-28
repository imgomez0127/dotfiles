;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ian Gomez"
      user-mail-address "ianm0127@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-moonlight)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;
;; transparent adjustment
(set-frame-parameter (selected-frame)'alpha '(90 . 90))
(add-to-list 'default-frame-alist'(alpha . (90 . 90)))

(setq doom-modeline-icon (display-graphic-p))

(setq doom-modeline-modal-icon t)

(setq doom-modeline-major-mode-icon t)

(setq doom-modeline-buffer-state-icon t)

(setq doom-modeline-buffer-modification-icon t)

;;Discord presence
(require 'elcord)
(elcord-mode)
;;(require 'gdscript-mode)

;;(load-file "~/.doom.d/plugins/spot4e/spot4e.el")
;;(setq spot4e-refresh-token "AQABtgSdFti1J62MJCCNdnIVOdwyu6yhff8P9EIn6FQzSde3XNXbWrJNneE_k8UaRDiix4MRx9pkLO4eiwi4i0cAED5UNVWp3lYQCO5WGoQ1piSCTJzIddn81LjAdAlhbEQ")
;;(run-with-timer 0 (* 60 59) 'spot4e-refresh)
;;
;;(global-set-key (kbd "C-c s s") 'spot4e-helm-search-tracks)
;;
;;(global-set-key (kbd "C-c s c") 'spot4e-player-play)
;;
;;(global-set-key (kbd "C-c s e") 'spot4e-player-pause)
;;
;;(global-set-key (kbd "C-c s r") 'spot4e-player-previous)
;;
;;(global-set-key (kbd "C-c s a") 'spot4e-helm-search-artists)
;;
;;(global-set-key (kbd "C-c s n") 'spot4e-player-next)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq frame-title-format "sadboi hours")

;;; save & shutdown when we get an "end of session" signal on dbus
(require 'dbus)

(defun my-register-signals (client-path)
  "Register for the 'QueryEndSession' and 'EndSession' signals from
Gnome SessionManager.

When we receive 'QueryEndSession', we just respond with
'EndSessionResponse(true, \"\")'.  When we receive 'EndSession', we
append this EndSessionResponse to kill-emacs-hook, and then call
kill-emacs.  This way, we can shut down the Emacs daemon cleanly
before we send our 'ok' to the SessionManager."
  (setq my-gnome-client-path client-path)
  (let ( (end-session-response (lambda (&optional arg)
                                 (dbus-call-method-asynchronously
                                  :session "org.gnome.SessionManager" my-gnome-client-path
                                  "org.gnome.SessionManager.ClientPrivate" "EndSessionResponse" nil
                                  t "") ) ) )
         (dbus-register-signal
          :session "org.gnome.SessionManager" my-gnome-client-path
          "org.gnome.SessionManager.ClientPrivate" "QueryEndSession"
          end-session-response )
         (dbus-register-signal
          :session "org.gnome.SessionManager" my-gnome-client-path
          "org.gnome.SessionManager.ClientPrivate" "EndSession"
          `(lambda (arg)
             (add-hook 'kill-emacs-hook ,end-session-response t)
             (kill-emacs) ) ) ) )

;; DESKTOP_AUTOSTART_ID is set by the Gnome desktop manager when emacs
;; is autostarted.  We can use it to register as a client with gnome
;; SessionManager.
(dbus-call-method-asynchronously
 :session "org.gnome.SessionManager"
 "/org/gnome/SessionManager"
 "org.gnome.SessionManager" "RegisterClient" 'my-register-signals
 "Emacs server" (getenv "DESKTOP_AUTOSTART_ID"))

(require 'calendar)
(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale.
With a prefix argument, the date is inserted without the day of
the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
		                        omit-day-of-week-p)))
(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\(CC?\\|cc\\|cxx\\|cpp\\|c++\\)\\'" . "C++ skeleton")
     '("Short description: "
       "/*******************************************************************************"\n
       " * Name    : " (file-name-nondirectory (buffer-file-name)) \n
       " * Author  : Ian Gomez" \n
       " * Date    : " (insdate-insert-current-date t) \n
       " * Description : " \n
       " * Github  : imgomez0127@github"\n
       " ******************************************************************************/" > \n
       "#include <iostream>" \n \n
       "using namespace std;" \n \n
       "int main(){" \n
       > _ \n
       "}" > \n)))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\(py\\)\\'" . "Python skeleton")
     '("Short description: "
       "#!/usr/bin/env python3"\n
       "\"\"\""\n
       "   Name    : " (file-name-nondirectory (buffer-file-name)) \n
       "   Author  : Ian Gomez" \n
       "   Date    : " (insdate-insert-current-date t) \n
       "   Description : " \n
       "   Github  : imgomez0127@github"\n
       "\"\"\"" > \n
       "if __name__ == \"__main__\":"\n
       "pass"
       )))
