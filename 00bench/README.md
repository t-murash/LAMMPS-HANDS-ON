# Kremer-Grest モデルの実行 00bench

`lammps-${version}/bench`にあるKremer-Grest モデルのExampleを動かしてみる。

+ `in.chain` プログラムの条件が書き込まれたインプットファイル
+ `data.chain` 高分子の本数M=320、高分子の長さN=100 のデータが入っているデータファイル

## 実行方法

```
mpirun -n N ./lmp_mpi < in.chain
```

**(注)**　`-n N` の N は実行時の並列数。

エラーが出てとまるはず。defaultの設定では分子のポテンシャルがインストールされていないため。

## moleculeパッケージの追加

```
cd lammps-${version}/src
make yes-molecule
make -jN mpi
```

**(注)** `make yes-${package}` でlammps-${version}/src にある${PACKAGE} のディレクトリ名を持つパッケージを追加することができる。

