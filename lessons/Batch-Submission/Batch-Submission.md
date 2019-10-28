Batch Submission
================

If you are performing a study that requires you to generate a large number of samples, e.g. a pull study, you will find that generating and fitting each sample sequentially will take a long time.
This is where a batch system becomes useful, instead of running a single job (or up to 10 for a 10 core CPU on lxplus) we can run 100s of jobs on Condor.

Preparing Condor for AmpGen
---------------------------

Condor has full access to any AFS file you have access to, so we need to tell Condor where to find our AmpGen executables, $AMPGENROOT/install/bin, and we also need the right kind of machine to run AmpGen,
we need

    - A x86_64 CPU with centos7
    - GCC version 8
    - ROOT that supports C++-17
    - A CPU that supports avx2 instructions (this is important for Tensor operations in AmpGen - one can build AmpGen without AVX2 support but Tensor operations will be slower)

to get these we just tell Condor what we want in out "submission" file

```
Requirements = $(requirements:True) && (TARGET.has_avx2)
```

we will also need to have a "wrapper" script, `exec.sh` to get us in the correct ROOT,GCC and python environment

```
source /cvmfs/sft.cern.ch/lcg/views/setupViews.sh LCG_94python3 x86_64-centos7-gcc8-opt
```

then we can put our AmpGen commands in `exec.sh` and Condor will execute them.

Since we are parrelising our work, it makes more sense to let each AmpGen process to just use a single thread so that at the cost of slower individual jobs we can perform many more at once. Since AmpGen is so efficient we don't really need to worry about this.
