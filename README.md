# SYNC

ローカルのフォルダとリモートのフォルダを同期させる。

## USAGE

* sync here remote:there
  ローカルの here フォルダをリモートのthereフォルダと動機させる。
  there を省略した場合、フォルダを推定する。

* sync remote:there
  ローカルの現在フォルダをリモートのthereフォルダと動機させる。
  there を省略した場合、フォルダを推定する。

* sync
  ローカルの現在フォルダをリモートの対応するフォルダと動機させる。
  リモートを推定する。
  リモートは tmac2 においては imac2、imac2 においては tmac2 になる。

## FIXME

## HISTORY

* /bin/sync と名前が被る。bdsync にコマンド名変更。2016-07-06

---
hiroshi.kimura.0331@gmail.com

