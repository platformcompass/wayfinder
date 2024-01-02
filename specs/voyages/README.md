tools must be run from within a specific voyage directory

## Usage
cue ls
cue build
cue seal
cue unseal
```bash


Notes: if running cue build, any encrypted secrets need to be decrypted for CUE to parse the values. Cue build silently runs and export without the secrets if it can't decrypt them.

ToDo: setup git commit hook to prevent committing unsealed secrets
```