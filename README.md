Terraformとlambrollの併用
=======================

# 手順
1. TerraformでLambda関数を作成する。
2. 2回目以降の関数デプロイは`lambroll init` -> `lambroll deploy`で行う。

> 最初に`lambroll init`するのは、function.jsonを最新の情報で上書きするため。
