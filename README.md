# actions

A collection of reusable GitHub Actions workflows for common development tasks.

## Available Workflows

### Codex PR Review

Automatically reviews pull requests using OpenAI's Codex AI to suggest improvements, potential bugs, and issues.

**Usage in your project:**

```yaml
name: PR Review

on:
  pull_request:
    branches:
      - master

jobs:
  # Your existing build/test job
  build-and-test:
    runs-on: ubuntu-24.04-arm
    steps:
      # ... your build steps

  # Codex review (runs after build-and-test)
  codex-review:
    uses: xhrdev/actions/.github/workflows/codex-pr-review.yml@master
    needs:
      - build-and-test
    secrets:
      openai-api-key: ${{ secrets.OPENAI_API_KEY }}
    with:
      timeout-minutes: 10  # Optional, defaults to 10
    permissions:
      contents: read
      issues: write
      pull-requests: write
```

**Required secrets:**
- `OPENAI_API_KEY`: Your OpenAI API key for Codex access

**Required permissions:**
- `contents: read`: To checkout and read the repository
- `issues: write`: To post review comments
- `pull-requests: write`: To post review comments

**Optional inputs:**
- `timeout-minutes`: Timeout for the codex job (default: 10)
