#### 排除
 git rm -r --cached .idea/
#### 変更を破棄して最後のコミットの状態に戻す
git addする前です

git checkout -- .
#### 全てを元に戻す
git checkout .
#### 特定のファイルの変更を取り消す
git checkout <ファイル名>
#### git addをした時の取り消し方
git reset ファイル名

#### コミットの取り消し方
 直近のcommitの変更点を確認する
 git diff HEAD~1
#### 直近のcommitを取り消す
git reset --soft HEAD^

#### ファイルを消してしまった場合
git restore .
git restore ファイル名
#### resource

https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/changing-a-commit-message

