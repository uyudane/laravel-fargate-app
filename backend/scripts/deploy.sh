#!/bin/bash

set -eu

# config ディレクトリ配下の 各設定ファイルの内容が「/bootstrap/cache/config.php」の 1ファイルにまとめられ、
# 設定ファイルへのアクセスが効率化
php artisan config:cache

php-fpm
