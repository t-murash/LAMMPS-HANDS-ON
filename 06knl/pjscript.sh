#!/bin/sh
#PJM -L rscgrp=regular-flat
#PJM -L node=1
#PJM --mpi proc=68
#PJM --omp thread=4
#PJM -L elapse=1:00:00
#PJM -g project_code
#PJM -j
sh ./run.sh
