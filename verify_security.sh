#!/bin/bash
# verify_security.sh — Quick security check before pushing
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${YELLOW}Security Verification${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 1. Check for API keys
echo "1. Scanning for API keys/tokens..."
if grep -r -iE "(sk-ant-api[a-zA-Z0-9]{20,}|ANTHROPIC_API_KEY\s*=\s*['\"]sk-)" . \
    --exclude-dir=.git \
    --exclude-dir=acestep.cpp \
    --exclude-dir=__pycache__ \
    --exclude="*.md" 2>/dev/null; then
    echo -e "${RED}   ✗ FOUND API KEYS!${NC}"
    exit 1
else
    echo -e "${GREEN}   ✓ No API keys found${NC}"
fi

# 2. Check .gitignore exists
echo ""
echo "2. Checking .gitignore..."
if [ -f ".gitignore" ]; then
    echo -e "${GREEN}   ✓ .gitignore exists${NC}"
    
    # Verify critical patterns
    if grep -q "^\.env$" .gitignore && \
       grep -q "models/" .gitignore && \
       grep -q "\.gguf" .gitignore; then
        echo -e "${GREEN}   ✓ Critical patterns included${NC}"
    else
        echo -e "${RED}   ✗ Missing critical patterns${NC}"
        exit 1
    fi
else
    echo -e "${RED}   ✗ .gitignore missing${NC}"
    exit 1
fi

# 3. Check .env is not tracked
echo ""
echo "3. Verifying .env is ignored..."
if [ -f ".env" ]; then
    if git check-ignore .env &>/dev/null || [ ! -d ".git" ]; then
        echo -e "${GREEN}   ✓ .env is properly ignored${NC}"
    else
        echo -e "${RED}   ✗ .env might be committed!${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}   ! .env doesn't exist (ok)${NC}"
fi

# 4. Check models directory
echo ""
echo "4. Checking models directory..."
if [ -d "models" ]; then
    MODEL_COUNT=$(ls -1 models/*.gguf 2>/dev/null | wc -l)
    if [ $MODEL_COUNT -gt 0 ]; then
        if git check-ignore models/*.gguf &>/dev/null || [ ! -d ".git" ]; then
            echo -e "${GREEN}   ✓ ${MODEL_COUNT} model files properly ignored${NC}"
        else
            echo -e "${RED}   ✗ Models might be committed!${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}   ! No models found (will need download)${NC}"
    fi
else
    echo -e "${YELLOW}   ! models/ doesn't exist${NC}"
fi

# 5. Check for large files
echo ""
echo "5. Scanning for large files (>10MB)..."
if [ -d ".git" ]; then
    LARGE_FILES=$(find . -type f -size +10M \
        ! -path "./.git/*" \
        ! -path "./models/*" \
        ! -path "./acestep.cpp/*" \
        ! -path "./.claude/*" 2>/dev/null)
    
    if [ -n "$LARGE_FILES" ]; then
        echo -e "${YELLOW}   ! Large files found:${NC}"
        echo "$LARGE_FILES" | while read file; do
            size=$(du -h "$file" | cut -f1)
            echo "     $size $file"
        done
        echo -e "${YELLOW}   → Verify these are in .gitignore${NC}"
    else
        echo -e "${GREEN}   ✓ No unexpected large files${NC}"
    fi
else
    echo -e "${YELLOW}   ! Git not initialized yet${NC}"
fi

# 6. Check README exists
echo ""
echo "6. Checking documentation..."
if [ -f "README.md" ]; then
    if grep -q "Security" README.md && grep -q "Environment" README.md; then
        echo -e "${GREEN}   ✓ README.md with security docs${NC}"
    else
        echo -e "${YELLOW}   ! README missing security section${NC}"
    fi
else
    echo -e "${RED}   ✗ README.md missing${NC}"
    exit 1
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✓ Security verification passed!${NC}"
echo ""
echo "Safe to push to GitHub."
echo ""
