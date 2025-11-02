# Mschnecke Gia

## How do I install these formulae?

`brew install mschnecke/gia/<formula>`

Or `brew tap mschnecke/gia` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "mschnecke/gia"
brew "<formula>"
```

## Automated Formula Updates

This tap is automatically updated when new releases are published in [github.com/mschnecke/gia](https://github.com/mschnecke/gia).

### GitHub Personal Access Token (PAT) Setup

To enable automated updates, a Personal Access Token must be configured in the main [gia repository](https://github.com/mschnecke/gia):

1. **Create the PAT** in your GitHub account:
   - Go to [GitHub Settings → Tokens](https://github.com/settings/tokens)
   - Click "Generate new token (classic)"
   - Name: `Homebrew Tap Automation`
   - Required scopes:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
   - Click "Generate token" and copy it immediately

2. **Add the PAT as a secret** in the main gia repository:
   - Go to [gia repository secrets](https://github.com/mschnecke/gia/settings/secrets/actions)
   - Click "New repository secret"
   - Name: `GH_PERSONAL_TOKEN`
   - Value: Paste the token you copied
   - Click "Add secret"

3. **Add the workflow file** to the main gia repository:
   - Create `.github/workflows/update-homebrew.yml` (see CLAUDE.md for workflow contents)

Once configured, every new release in the gia repository will automatically update the formula in this tap with the correct version and SHA256 hashes.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

