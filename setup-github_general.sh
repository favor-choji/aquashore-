#!/usr/bin/env bash
set -euo pipefail

# 1. Get User Input
read -p "Enter GitHub Username (e.g., favor-choji): " GH_USER
read -p "Enter GitHub Email (e.g., garosepamchoji@gmail.com): " GH_EMAIL
read -p "Enter Repository Name (e.g., aquashore-): " REPO_NAME

echo "Configuring local repo settings..."

# 2. Set Local Username and Email (Only for this folder)
git config user.name "$GH_USER"
git config user.email "$GH_EMAIL"
echo "✓ Local user set to: $GH_USER <$GH_EMAIL>"

# 3. Set the Remote URL (Using HTTPS, explicitly including the username)
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GH_USER}@github.com/${GH_USER}/${REPO_NAME}.git"
echo "✓ Remote set to: https://${GH_USER}@github.com/${GH_USER}/${REPO_NAME}.git"

# 4. Push
echo "Pushing to GitHub..."
echo "⚠️  WHEN PROMPTED FOR A PASSWORD, PASTE YOUR GITHUB PERSONAL ACCESS TOKEN (PAT)"

# Bypass the Mac Keychain for this folder so it doesn't use your global account
git config --local --unset credential.helper || true
git push -u origin main

echo "✅ Done!"