# scraps.nvim

By Rémino Rem <https://remino.net/>

Plugin to browse scraps (snippets) directory in Neovim.

<https://github.com/remino/scraps.nvim/>

- [About](#about)
  - [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Acknowledgments](#acknowledgments)

## About

Like many developers out there, I have a directory where I keep several
snippets. There are many snippet plugins out there, but they all require
snippets to be in a specific format. I just wanted to keep some plain code files
in a directory, which I call "scraps", have an easy way to browse them, and
either open files or immediately paste the file's content into the current
buffer. For this reason, I created this plugin.

[Back to top](#scrapsnvim)

## Getting Started

### Prerequisites

This plugin requires
[Telescope](https://github.com/nvim-telescope/telescope.nvim).

### Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
	"remino/scraps.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	cmd = { "Scraps", "ScrapsConfigDir", "ScrapsCurrentDir" },
	opts = {
		scraps_dir = "~/scraps", -- Optional. Defaults to ~/.local/share/scraps.
	},
	keys = {
		{ "<leader>fs", ":Scraps<CR>", desc = "Browse scraps" },
	},
}
```

[Back to top](#scrapsnvim)

## Usage

This adds three commands:

- `:Scraps` to browse the scraps directory.
- `:ScrapsConfigDir` to browse the configuration directory.
- `:ScrapsCurrentDir` to browse the current directory.

These use the Telescope `find_files` browser. You can open a file by pressing
`<CR>`, or paste its content into the current buffer by pressing `<C-p>`.

[Back to top](#scrapsnvim)

## Contributing

Contributions are what make the open source community such an amazing place to
learn, inspire, and create. Any contributions you make are **greatly
appreciated**.

If you have a suggestion that would make this better, please fork the repo and
create a pull request. You can also simply open an issue with the tag
"enhancement". Don't forget to give the project a star! Thanks again!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

[Back to top](#scrapsnvim)

## License

Distributed under the ISC License. See `LICENSE.txt` for more information.

[Back to top](#scrapsnvim)

## Contact

Rémino Rem <https://remino.net/>

[Back to top](#scrapsnvim)
