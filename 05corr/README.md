# 応力の相関関数 04corr

応力の相関関数を計算する際、最近は Multiple-tau 法[1]がよく用いられる。LAMMPSにも実装されている (fix ave/correlate/long) ので試してみる。

```
mpirun -n N ./lmp_mpi < in.chain.corr
mpirun -n N ./lmp_mpi < in.chain.corr.restart # リスタートする場合の例
```

## 引用文献
[1] J. Ramirez, S. K. Sukumaran, B. Vorselaars, A. E. Likhtman, J. Chem. Phys. 133, 154103 (2010).