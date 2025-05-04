# TheFox' Homebrew Tap

## How do I install these formulae?

1. Add the `thefox/brewery` tap to brew.

	```bash
	brew tap thefox/brewery
	```

2. Install a formula.

	```bash
	brew install <formula>
	```

## Add a new formulae

1. Create template file in [`skel`](skel).
2. Run release script

	```bash
	./bin/release.sh name 1.2.3
	```

3. Test formulae local:

	```bash
	brew install ./name.rb
	```

## Add a formulae from foreign Source

In [`bin/release`](bin/release) the `GITHUB_BASE_URL` variable is set to `https://github.com/TheFox`. To create a formulae for a foreign programm run it like this:

```bash
$ export GITHUB_BASE_URL=https://github.com/drinchev
$ ./bin/release.sh phook 0.0.4
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://github.com/Homebrew/brew/blob/master/docs/README.md#readme).

### Local Path

```
/usr/local/Homebrew/Library/Taps/thefox/homebrew-brewery/
```
