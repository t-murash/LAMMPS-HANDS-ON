# 応力の相関関数 05corr

応力の相関関数を計算する際、最近は Multiple-tau 法[1]がよく用いられる。LAMMPSにも実装されている (fix ave/correlate/long) ので試してみる。

## USER-MISC の追加
```
cd lammps-${version}/src
make yes-extra-fix
make -jN mpi
```
**(注)** 環境によってはエラーが出てコンパイルできないことがある。その場合は、`-restrict` オプションを`Makefile.mpi` に追加する。 
```
#CCFLAGS = -g -O3
CCFLAGS = -g -O3 -restrict
```

## Multiple-tau 法の設定箇所
```
fix ave2 all ave/correlate/long 1 100 &
v_pxxyy v_pxxzz v_pyyzz v_pxy v_pxz v_pyz file corr.dat overwrite ncorr 40
```
v_pxxyy, v_pxxzz, v_pyyzz の定義は以下のとおり。
```
variable pxxyy equal (v_pxx-v_pyy)*0.5
variable pxxzz equal (v_pxx-v_pzz)*0.5
variable pyyzz equal (v_pyy-v_pzz)*0.5
```


## 実行
```
mpirun -n N ./lmp_mpi -in in.chain.corr
mpirun -n N ./lmp_mpi -in in.chain.corr.restart # リスタートする場合の例
```

## 引用文献
[1] J. Ramirez, S. K. Sukumaran, B. Vorselaars, A. E. Likhtman, J. Chem. Phys. 133, 154103 (2010).
