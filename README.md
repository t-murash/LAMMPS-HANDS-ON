# 準備

## ダウンロード
LAMMPS の最新版(7Aug2019)をダウンロード。

**(注)** ファイルサイズ **_384MB_** 

+ [LAMMPSのダウンロードページ](https://lammps.sandia.gov/download.html)


## インストール
```
wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
tar xvf lammps-stable.tar.gz
cd lammps-${version}/src
make -jN mpi
```
`-jN` はmake を並列で実行するためのオプション。 N のところには数字が入る。

**(注)** Nはmake時の並列数であり、LAMMPS実行時の並列数とは関係無し。

# 内容
1. [Kremer-Grestモデルの実行 01bench](./01bench) 
1. [リスタート方法 02restart](./02restart)
1. [トラジェクトリーデータ出力＆可視化 03dump](./03dump)
1. [せん断変形、伸長変形の方法 04deform](./04deform)
1. [応力の相関関数 05corr](./05corr)
1. [Xeon Phi 06knl](./06knl)
1. [Paraview による可視化 07vtk](./07vtk)


