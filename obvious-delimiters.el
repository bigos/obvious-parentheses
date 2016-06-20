;;; obvious-delimiters.el --- Making rainbow-delimiters more obvious

;; Copyright (C) 2016 Jacek Podkanski
;;
;; Author: Jacek Podkanski
;; URL: https://github.com/bigos/obvious-parentheses
;; Package-Requires: ((emacs "24") (rainbow-delimiters ))
;; Version: 0.1
;; Keywords: convenience, usability

;; This file is not part of GNU Emacs.

;;; License:

;; Licensed under the same terms as Emacs.

;;; Commentary:

;; Quick start:
;; load rainbow-delimiters-mode
;; run (colorize-brackets) or M-x colorize-brackets
;;
;; For a detailed introduction see:
;; https://github.com/bigos/obvious-parentheses

;;; Code:

(require 'rainbow-delimiters)

(require 'color)

(defun hsl-to-hex (h s l)
  "Convert H S L to hex colours."
  (let (rgb)
    (setq rgb (color-hsl-to-rgb h s l))
    (color-rgb-to-hex (nth 0 rgb)
                      (nth 1 rgb)
                      (nth 2 rgb))))

(defun bracket-colors ()
  "Calculate the bracket colours based on background."
  (let (hexcolors lightvals)
    (if (>= (color-distance  "white"
                             (face-attribute 'default :background))
            (color-distance  "black"
                             (face-attribute 'default :background)))
        (setq lightvals (list 0.65 0.55))
      (setq lightvals (list 0.35 0.30)))

    (append
                 (dolist (n'(.71 .3 .11 .01))
                   (push (hsl-to-hex (+ n 0.0) 1.0 (nth 0 lightvals)) hexcolors))
                 (dolist (n '(.81 .49 .17 .05))
                   (push (hsl-to-hex (+ n 0.0) 1.0 (nth 1 lightvals)) hexcolors)))
    (reverse hexcolors)))

;;;###autoload
(defun colorize-brackets ()
  "Apply my own colours to rainbow delimiters."
  (interactive)
  (require 'rainbow-delimiters)
  (custom-set-faces
   ;; or use (list-colors-display)
   `(rainbow-delimiters-depth-1-face ((t (:foreground "#888"))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,(nth 0 (bracket-colors))))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,(nth 1 (bracket-colors))))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,(nth 2 (bracket-colors))))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,(nth 3 (bracket-colors))))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,(nth 4 (bracket-colors))))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,(nth 5 (bracket-colors))))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,(nth 6 (bracket-colors))))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,(nth 7 (bracket-colors))))))
   `(rainbow-delimiters-unmatched-face ((t (:foreground "white" :background "red"))))
   `(highlight ((t (:foreground "#ff0000" :background "#888"))))
   ))


;;; obvious-delimiters.el ends here
