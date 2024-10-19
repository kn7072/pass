tar cfzv wrap.tar.gz --exclude='*.tar.gz*' --exclude='readme.md' --exclude='.git' * 
gpg -e -r $1 wrap.tar.gz
rm wrap.tar.gz
