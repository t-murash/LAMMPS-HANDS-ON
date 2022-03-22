# せん断変形、伸長変形の方法 04deform
1. せん断変形 `in.chain.shear`、伸長変形 `in.chain.uni`を行う
1. 圧力テンソル（応力テンソルに負符号つけたもの）をvariableで定義し、fix ave/time でファイル出力
1. トラジェクトリーデータを可視化

## せん断変形の設定箇所
```
fix 1 all nve
fix 2 all langevin 1.0 1.0 2.0 904297
fix 3 all deform 1 xy erate 0.01 remap v
compute mytemp all temp/deform
fix_modify 2 temp mytemp
```
ひずみ速度0.01の変形をかける設定。fix_modify で変形によって生じる速度を考慮する。


## 圧力テンソルの定義箇所
```
compute mypress all pressure mytemp
variable pxx equal c_mypress[1]
variable pyy equal c_mypress[2]
variable pzz equal c_mypress[3]
variable pxy equal c_mypress[4]
variable pxz equal c_mypress[5]
variable pyz equal c_mypress[6]
```

## 圧力テンソルのファイル出力の設定箇所
```
fix ave1 all ave/time 1 100 100 v_pxx v_pyy v_pzz v_pxy v_pxz v_pyz c_mytemp file shear-stress.txt
```

**(注)** compute で定義された変数名には`c_`, variable で定義された変数名には`v_`をつける。

## せん断変形
 
```
mpirun -n N ./lmp_mpi -in in.chain.shear
```

![せん断変形](img/dump.u.shear.gif)

**(注)** 変形を強調するためせん断速度が大きな値を使っています。

## 一軸伸長変形

```
mpirun -n N ./lmp_mpi -in in.chain.uni
```

![伸長変形](img/dump.u.uni.gif)