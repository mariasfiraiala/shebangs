# Learn bash scripting and oneliners through exercise

## Bash scripts

Check out the demos. Every directory should include its own README.md, explaining the implementation.

## Oneliners

Until I get a better idea regarding the organization of this section, this README.md should do the trick:

### Get the total lines of code in a directory, excluding the secret files

```bash
find . -type f \( ! -iname ".*" \) -exec wc -l {} \; | awk '{ total += $1 } END {print total}'
```