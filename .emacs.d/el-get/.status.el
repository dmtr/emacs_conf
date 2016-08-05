((el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:features el-get :post-init
		(when
		    (memq 'el-get
			  (bound-and-true-p package-activated-list))
		  (message "Deleting melpa bootstrap el-get")
		  (unless package--initialized
		    (package-initialize t))
		  (when
		      (package-installed-p 'el-get)
		    (let
			((feats
			  (delete-dups
			   (el-get-package-features
			    (el-get-elpa-package-directory 'el-get)))))
		      (el-get-elpa-delete-package 'el-get)
		      (dolist
			  (feat feats)
			(unload-feature feat t))))
		  (require 'el-get))))
 (evil status "installed" recipe
       (:name evil :website "https://bitbucket.org/lyro/evil" :description "Evil is an extensible vi layer for Emacs. It\n       emulates the main features of Vim, and provides facilities\n       for writing custom extensions." :type hg :url "https://bitbucket.org/lyro/evil" :features evil :depends
	      (undo-tree goto-chg)
	      :build
	      (("make" "info" "all"))
	      :build/berkeley-unix
	      (("gmake" "info" "all"))
	      :build/darwin
	      `(("make" ,(format "EMACS=%s" el-get-emacs)
		 "info" "all"))
	      :info "doc"))
 (goto-chg status "installed" recipe
	   (:name goto-chg :description "Goto the point of the most recent edit in the buffer." :type emacswiki))
 (helm status "installed" recipe
       (:name helm :description "Emacs incremental completion and narrowing framework" :type github :pkgname "emacs-helm/helm" :autoloads "helm-autoloads" :build
	      (("make"))
	      :build/darwin
	      `(("make" ,(format "EMACS_COMMAND=%s" el-get-emacs)))
	      :build/windows-nt
	      (let
		  ((generated-autoload-file
		    (expand-file-name "helm-autoloads.el"))
		   \
		   (backup-inhibited t))
	      (update-directory-autoloads default-directory)
	      nil)
       :features "helm-config" :post-init
       (helm-mode)))
(undo-tree status "installed" recipe
(:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/")))
