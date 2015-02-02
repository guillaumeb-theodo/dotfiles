#!/bin/sh
mkdir -p /tmp/zsh/.zsh
cp -r . /tmp/zsh/.zsh
ln -s .zsh/zshrc /tmp/zsh/.zshrc
rm /tmp/zsh/.zsh/history
tar -czf zsh.tar.gz -C /tmp/zsh .zsh .zshrc
rm -rf /tmp/zsh
