# TheFox' Homebrew Tap

## How do I install these formulae?

1. Add the `thefox/brewery` tap to brew.

		brew tap thefox/brewery

2. Install a formula.

		brew install <formula>

## Add a new formulae

1. Create template file in [`skel`](skel).
2. Run release script

	./bin/release name 1.2.3

3. Test formulae local:

	brew install ./name.rb

## Add a formulae from foreign Source

In [`bin/release`](bin/release) the `GITHUB_BASE_URL` variable is set to `https://github.com/TheFox`. To create a formulae for a foreign programm run it like this:

	export GITHUB_BASE_URL=https://github.com/drinchev
	./bin/release phook 0.0.4

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://github.com/Homebrew/brew/blob/master/docs/README.md#readme).
