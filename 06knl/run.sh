#!/bin/sh
source /usr/local/bin/mpi_core_setting.sh
MPI="mpiexec.hydra"        
NUMA="numactl --preferred=1"

export LMP_BIN=./lmp_knl 
export LMP_CORES=68
export LMP_THREADS_LIST="4"
export LMP_ARGS="-pk intel 0 -sf intel -screen none" 
export LOG_DIR=.
export KMP_BLOCKTIME=0
export WORKLOADS="airebo chain dpd eam lc lj rhodo sw tersoff water" 

echo "Creating restart file...."
$MPI -n $LMP_CORES $LMP_BIN -in in.lc_generate_restart -log none $LMP_ARGS
echo "Done."

for threads in $LMP_THREADS_LIST
do
    export OMP_NUM_THREADS=$threads
    for workload in $WORKLOADS
    do
	export LOGFILE=$LOG_DIR/$workload.$LMP_CORES"c"$threads"t".log
	echo "Running $LOGFILE"
	$MPI -n $LMP_CORES $NUMA $LMP_BIN -in in.intel.$workload -log $LOGFILE $LMP_ARGS
    done
done
