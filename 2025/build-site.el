(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(package-install 'htmlize)

(require 'ox-publish)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" href=\"style.css\" />")

(defun file-contents (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(setq org-publish-project-alist
      (list
       (list "webpage"
             :recursive t
             :base-directory "./content"
             :publishing-directory "."
             :publishing-function 'org-html-publish-to-html
             :html-preamble (file-contents "html_preamble.html")
             :with-author nil
             :with-creator t
             :with-toc t
             :section-numbers nil
             :time-stamp-file nil
             :html-doctype "html5"
             :html-html5-fancy t
             :htmlized-source t
             )))


(org-publish-all t)

(message "Build Complete!")
