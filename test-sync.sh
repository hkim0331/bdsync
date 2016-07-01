#!/bin/sh
#
#OK
echo '* ローカルのカレントフォルダとリモートの同じフォルダを同期させる'
echo ./sync.rb
./sync.rb
echo

#ローカルのカレントフォルダを含むフォルダがリモートに存在していないとエラーになる。
echo '* ローカルのカレントフォルダとリモートの同じフォルダを同期させる'
echo ./sync.rb sandbox.local:
./sync.rb sandbox.local:
echo

# OK
echo '* ローカルのカレントフォルダをリモートのthereフォルダと同期させる'
echo ./sync.rb sandbox.local:there
./sync.rb sandbox.local:there
echo

#OK
echo 'ローカルの here フォルダをリモートのthereフォルダと同期させる'
echo ./sync.rb here sandbox.local:there
./sync.rb here sandbox.local:there
echo

# echo '* ポートテスト'
# echo ./sync.rb --port=2222
# ./sync.rb --port=2222

# echo ./sync.rb -p 2222 sandbox.local:there
# ./sync.rb -p 2222 sandbox.local:there

# echo ./sync.rb --port=2222 -p 23 here sandbox.local:there
# ./sync.rb --port=2222 -p 23 here sandbox.local:there

