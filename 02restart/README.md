# リスタート方法 02restart

リスタートファイルの書き出し、読み込みを行う。

1. in.chain.write_restart リスタートファイルの書き出し

    00benchで使ったdata.chain を読み込み、res.chain.100 を書き出す

2. in.cahin.read_restart リスタートファイルの読み込み 

    res.chain.100 を読み込み、res.chain.200 を書き出す

## リスタートファイルの書き出し

```
mpirun -n N ./lmp_mpi < in.chain.write_restart
```

### リスタートファイルを書き出している箇所

```
# write_data data.chain.100   # configuration data only
write_restart res.chain.100 # configuration data & simulation condition
```

`write_restart` でバイナリファイルが出力される。

**(注)** `write_data` を用いるとテキストファイルが出力されるがシミュレーション中の細かい条件等は保存されない。


## リスタートファイルの読み込み

```
mpirun -n N ./lmp_mpi < in.chain.read_restart
```

### リスタートファイルを読み込んでいる箇所
```
#read_data	data.chain
read_restart	res.chain.100
```

