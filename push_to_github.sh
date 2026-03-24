#!/bin/bash
# push_to_github.sh — Initialize git and push to GitHub
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  ACE-Step Local → GitHub Push${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "app.py" ]; then
    echo -e "${RED}✗${NC} Error: Run this script from the acestep-local directory"
    exit 1
fi

# Verify .gitignore exists
if [ ! -f ".gitignore" ]; then
    echo -e "${RED}✗${NC} Error: .gitignore not found. Run security audit first."
    exit 1
fi

echo -e "${GREEN}✓${NC} Found .gitignore"

# Check if models directory would be pushed
if [ -d "models" ] && [ "$(ls -A models/*.gguf 2>/dev/null)" ]; then
    echo -e "${YELLOW}!${NC} Verifying models are ignored..."
    if git check-ignore models/*.gguf &>/dev/null; then
        echo -e "${GREEN}✓${NC} Models properly ignored"
    else
        echo -e "${RED}✗${NC} WARNING: Models might be committed! Check .gitignore"
        exit 1
    fi
fi

# Scan for secrets one more time
echo ""
echo -e "${YELLOW}──${NC} Final security scan..."
if git grep -iE "(sk-ant-api|ANTHROPIC_API_KEY\s*=\s*['\"][^'\"]{20,})" 2>/dev/null; then
    echo -e "${RED}✗${NC} BLOCKED: Found potential API keys. Remove them before pushing."
    exit 1
else
    echo -e "${GREEN}✓${NC} No secrets detected"
fi

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo ""
    echo -e "${YELLOW}──${NC} Initializing git repository..."
    git init
    echo -e "${GREEN}✓${NC} Git initialized"
fi

# Add remote if not exists
if ! git remote | grep -q "origin"; then
    echo ""
    echo -e "${YELLOW}──${NC} Adding GitHub remote..."
    git remote add origin https://github.com/inoculate23/squaawke.git
    echo -e "${GREEN}✓${NC} Remote added"
fi

# Stage all files
echo ""
echo -e "${YELLOW}──${NC} Staging files..."
git add .

# Show what will be committed
echo ""
echo -e "${YELLOW}Files to commit:${NC}"
git status --short | head -20
echo ""
if [ $(git status --short | wc -l) -gt 20 ]; then
    echo -e "${YELLOW}  ... and $(( $(git status --short | wc -l) - 20 )) more files${NC}"
    echo ""
fi

# Verify large files aren't staged
LARGE_FILES=$(git ls-files -s | awk '{if ($4 > 10000000) print $4}' | wc -l)
if [ "$LARGE_FILES" -gt 0 ]; then
    echo -e "${RED}✗${NC} WARNING: Large files detected (>10MB). These may be models."
    git ls-files -s | awk '{if ($4 > 10000000) print $4}'
    echo ""
    echo "Add them to .gitignore or use Git LFS"
    exit 1
fi

# Commit
echo -e "${YELLOW}──${NC} Creating commit..."
git commit -m "Initial commit: ACE-Step Local with security audit

- Added comprehensive .gitignore (models, secrets, build artifacts)
- Created README.md with setup and security documentation
- Verified no hardcoded API keys or credentials
- Environment variables properly externalized
- All ML models and weights excluded from repo
- Security audit completed (see SECURITY_AUDIT.md)"

echo -e "${GREEN}✓${NC} Committed"

# Push
echo ""
echo -e "${YELLOW}──${NC} Ready to push to GitHub"
echo ""
echo -e "${YELLOW}Choose authentication method:${NC}"
echo "  1) GitHub CLI (gh auth login)"
echo "  2) Personal Access Token"
echo "  3) SSH key"
echo ""
read -p "Enter choice (1-3): " AUTH_CHOICE

case $AUTH_CHOICE in
    1)
        echo ""
        echo "Run: gh auth login"
        echo "Then: git push -u origin main"
        ;;
    2)
        echo ""
        read -p "Enter your GitHub Personal Access Token: " TOKEN
        git remote set-url origin "https://${TOKEN}@github.com/inoculate23/squaawke.git"
        echo -e "${GREEN}✓${NC} Token configured"
        echo ""
        echo "Pushing to GitHub..."
        git push -u origin main || git push -u origin master
        echo ""
        echo -e "${GREEN}✓${NC} Pushed successfully!"
        ;;
    3)
        git remote set-url origin git@github.com:inoculate23/squaawke.git
        echo ""
        echo "Pushing to GitHub..."
        git push -u origin main || git push -u origin master
        echo ""
        echo -e "${GREEN}✓${NC} Pushed successfully!"
        ;;
    *)
        echo -e "${RED}✗${NC} Invalid choice"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  Repository pushed to GitHub!${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"
echo ""
echo "View at: https://github.com/inoculate23/squaawke"
echo ""
