#!/usr/bin/env bash
set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting GitHub Repository Setup${NC}"
echo "----------------------------------------"

# 1. Get User Input
read -p "Enter the GitHub Username (for the new account): " GH_USER
read -p "Enter the GitHub Email (for the new account): " GH_EMAIL
read -p "Enter the Repository Name (e.g., aquashore-marine): " REPO_NAME

# Construct the GitHub URL
REPO_URL="https://github.com/${GH_USER}/${REPO_NAME}.git"

echo -e "\n${YELLOW}Configuring local Git settings for this project only...${NC}"

# 2. Initialize Git (if not already initialized)
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}✓ Git initialized.${NC}"
else
    echo -e "${GREEN}✓ Git already initialized.${NC}"
fi

# 3. Set Local Config (Crucial: This only affects this folder, not your whole Mac)
git config user.name "$GH_USER"
git config user.email "$GH_EMAIL"
echo -e "${GREEN}✓ Local Git user set to: $GH_USER <$GH_EMAIL>${NC}"

# 4. Ensure .gitignore exists (crucial for Node projects)
if [ ! -f ".gitignore" ]; then
    cat <<EOT > .gitignore
node_modules/
dist/
.astro/
.env
.env.production
.DS_Store
EOT
    echo -e "${GREEN}✓ Created standard .gitignore${NC}"
fi

# 5. Stage and Commit
echo -e "\n${YELLOW}Staging and committing files...${NC}"
git add .
# Only commit if there are changes to commit
if ! git diff-index --quiet HEAD --; then
    git commit -m "Initial commit: Aquashore Marine Tailwind Build"
    echo -e "${GREEN}✓ Initial commit created.${NC}"
else
    echo -e "${YELLOW}No changes to commit (already committed).${NC}"
fi

# 6. Set the Remote URL
echo -e "\n${YELLOW}Setting remote URL...${NC}"
# Remove existing origin if it exists
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"
echo -e "${GREEN}✓ Remote set to: $REPO_URL${NC}"

# 7. Rename branch to main
git branch -M main

# 8. Push
echo -e "\n${BLUE}🚀 Pushing to GitHub...${NC}"
echo -e "${YELLOW}NOTE: If prompted for a password, paste your Personal Access Token (PAT).${NC}"
echo "----------------------------------------"

# We temporarily unset the credential helper to force Git to ask for the new token
# instead of using the saved credentials of your default account.
git config --local --unset credential.helper || true
git push -u origin main

echo -e "\n${GREEN}✅ Successfully pushed to GitHub!${NC}"
echo -e "View your repository here: ${BLUE}https://github.com/${GH_USER}/${REPO_NAME}${NC}"