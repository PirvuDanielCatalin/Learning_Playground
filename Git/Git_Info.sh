# ==============================================================
# Cum sterg branch-uri/tag-uri publicate?
# ==============================================================
# -- Branch --
Branch=''; git branch -D $Branch; git push origin --delete $Branch
# ==============================================================
# -- Tag --
Tag=''; git tag --delete $Tag; git push origin --delete $Tag
# ==============================================================

# ==============================================================
# Squash commits
# ==============================================================
git checkout $Branch
git reset $(git merge-base develop $Branch)
git add -A
git commit -m "$Mesaj"
git push -f
# ==============================================================

# ==============================================================
# Git push / pull
# ==============================================================
# -- Push --
git rebase -i HEAD~${Numar_Committuri}
git rebase --continue
git git push origin $Branch --force
# ==============================================================
# -- Pull --
git fetch origin $Branch
git reset --hard origin/$Branch
# ==============================================================
# -- Commit --
git add .
git commit --amend -m "Mesaj"
git push --force
# ==============================================================
