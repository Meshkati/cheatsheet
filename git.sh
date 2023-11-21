# # Add hunks instead of the whole file
# y for yes, n for no, q for quit, a for all hunks, hjkl for scroll
git add -p path/to/the/file.txt

# List unpushed commits
git log origin/master..HEAD
git log --stat origin/master..HEAD
git diff origin/master..HEAD