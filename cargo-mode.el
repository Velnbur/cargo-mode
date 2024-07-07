;;; cargo-mode.el --- Mode for cargo files -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Velnbur
;;
;; Author: Velnbur <kyrylobaybula@gmail.com>
;; Maintainer: Velnbur <kyrylobaybula@gmail.com>
;; Created: липня 07, 2024
;; Modified: липня 07, 2024
;; Version: 0.0.1
;; Keywords: convenience data extensions files help languages local processes
;; Homepage: https://github.com/velnbur/cargo-mode
;; Package-Requires: ((emacs "26.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Mode for cargo files
;;
;;; Code:

(require 'projectile)
(require 'straight)

(defconst cargo-mode-manifest-file-name
  "Cargo.toml")

;;;###autoload
(defun cargo-mode-project-manifest ()
  "Open project `Cargo.toml' manifest file and at project root"
  (interactive)
  (let* (;; get root of the project file
         (root (projectile-project-root))
         ;; project-root/Cargo.toml - should be the the projects manifest file.
         (manifest-path  (concat (file-name-as-directory root) cargo-mode-manifest-file-name)))
    (find-file manifest-path)))

;;;###autoload
(defun cargo-mode-nearest-manifest ()
  "Open nearest to current buffer (file) `Cargo.toml' manifest file."
  (interactive)
  (let* ((current-file (buffer-file-name))
         (manifest-file (cargo-mode-nearest-manifest-from-path current-file)))
    (find-file manifest-file)))

(defun cargo-mode-nearest-manifest-from-path (path)
  "Returns possible path to nearest `Cargo.toml' from `PATH' by
 finding `src' dir in it and trimming it."
  (let (;; trim anything to the left of the `/src/'
        (trimmed-src-dir-path (cargo-mode-src-trim-path path)))
    (concat (file-name-as-directory trimmed-src-dir-path) cargo-mode-manifest-file-name)))

(defun cargo-mode-src-trim-path (path)
  "Trim path upto `src' dir."
  (car (split-string path "src")))

(provide 'cargo-mode)
;;; cargo-mode.el ends here
