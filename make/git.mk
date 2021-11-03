setup-git:
	git config --global --replace-all core.pager "less -F -X"
	git config --global rebase.autosquash true
	git config --global color.ui true
	git config --global core.editor vim
