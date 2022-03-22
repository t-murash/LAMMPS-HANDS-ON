# Xeon Phi 06knl

**(注)** このページはLAMMPS 7Aug2019 の情報で、最新版の内容に更新していません。

LAMMPS は一部のコードが Xeon Phi x200 Knights Landing (KNL) に対応しており、[Oakforest-PACS](https://www.cc.u-tokyo.ac.jp/supercomputer/ofp/service/) で試してみる。 `USER-INTEL/TEST` を少し変更した。



## USER-INTEL, USER-OMP 他、パッケージの追加
```
cd lammps-${version}/src
make yes-asphere yes-class2 yes-kspace yes-manybody
make yes-misc yes-molecule
make yes-mpiio yes-opt yes-replica yes-rigid
make yes-user-omp yes-user-intel
cp ./MAKE/OPTIONS/Makefile.knl ./MAKE/.
make -j8 knl
```
<https://software.intel.com/en-us/articles/recipe-lammps-for-intel-xeon-phi-processors>


## USER-INTEL を使用する場合のインプットファイルの変更箇所
各インプットファイル `in.intel.***` を覗くと、`nve/intel`、`lj/cut/intel` のように、通常のコマンド名に`/intel` をつければよい。力の計算と時間発展のコマンドをスレッド並列化している。`USER-INTEL`内のファイルからどのコマンドが対応しているかわかる。


## 実行
`pjscript.sh` 中の下記の行
```
#PJM -g project_code
```
を各プロジェクトに割り当てられる `project_code` に変更後、実行する。
```
pjsub pjscript.sh
```

LAMMPS を実行する際のコマンドは `run.sh` 内に記述しているが
```
mpiexec.hydra -n 68 numactl --preferred=1 ./lmp_knl -in in.intel.*** -pk intel 0 -sf intel
```
のようにする。後ろの `-pk intel 0 -sf intel` をつけると Intel Processor で最適化されるらしい。

## 結果

### Intel Xeon Phi 7250 (68 cores, 4 threads)

| model | timesteps/sec |
|:---:|---:|
| airebo | 12.485 |
| chain | 135.520 |
| dpd | 100.793 |
| eam | 90.112 |
| lc | 26.258 |
| lj | 285.696 |
| rhodo | 18.462 |
| sw | 167.165 |
| tersoff | 102.689 |
| water | 99.982 |

* `USER-INTEL/TEST/README` に載っているベンチマークの結果に相当する値が出た。繰り返す度に結果は多少変動する。
* `in.intel.chain` の `fix langevin` の箇所はスレッド並列化されていないので、高速化の余地あり。

ちなみに、Xeon 6148 (x2) での実行結果（下記）の方が少しよい。

### Intel Xeon 6148 (x2) (40 cores, 1 threads)

* `Makefile.intel_cpu_intelmpi` の `-xHost` を `-xCORE-AVX512` に変更して、make。

```
make -j8 intel_cpu_intelmpi
```

| model | timesteps/sec |
|:---:|---:|
| airebo | 15.378 |
| chain | 231.960 |
| dpd | 110.010 |
| eam | 120.297 |
| lc | 21.413 |
| lj | 319.598 |
| rhodo | 23.726 |
| sw | 242.406 |
| tersoff | 103.166 |
| water | 93.175 |


