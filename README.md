vim-biblereader
===============

A bible reader for vim. It uses `diatheke` to access sword modules.

Usage
-----

You have two commands. Both will prompt you for your choice.

- `:call FindInBible()` will open a horizontal window
- `:call VFindInBible()` will open a vertical window
- `:call PasteVerse()` will paste a bible verse

For more information on these commands see the documentation.

Installation
------------

With [pathogen][] it's just a matter of `git clone`:

	cd $HOME/.vim/bundle
	git clone https://github.com/sirjofri/vim-biblereader.git

If you use submodules:

	cd $HOME/.vim/bundle
	git submodule add https://github.com/sirjofri/vim-biblereader.git

You need to have sword installed. It contains the `diatheke` command. On [Arch Linux][]
you can use `pacman -S sword`.

You can find sword modules here: [link][sword]

License
-------

Beerware. If you want you can give me some gift. (I prefer dark german beer.)


[pathogen]: https://github.com/tpope/vim-pathogen/
[Arch Linux]: https://www.archlinux.org/
[sword]: http://crosswire.org/sword/modules/
