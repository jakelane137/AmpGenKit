Getting Started with AmpGen
===========================

Introduction
------------

If you study any multi-body decay (that is 3 or more particles in the final state), you may want to do "amplitude analysis" of these decays. AmpGen is (as the name implies) a software suite that lets you study amplitudes of multi-body decays.

Why AmpGen?
-----------

AmpGen is one of many kinds of software that do amplitude analysis, so why would you want to choose AmpGen in particular? AmpGen was derived from an older software suite called Mint2 which was written by Professor Jonas Rademacker, AmpGen was a project that was explicitly designed to speed up Mint2 by simplifying many of its functions and libraries (particularly the Generator) as well as optimising the C++ code which allows AmpGen to significantly outperform Mint2.

Why not AmpGen?
---------------

AmpGen (currently) only runs on CPUs (via OpenMP) thus if your heart is set on using GPUs for compute, GooFit - a portmanteau of GPU and RooFit - may be for you. AmpGen shares a repository with GooFit located at [github.com/GooFit/GooFit](github.com/GooFit/GooFit).

Getting AmpGen
--------------

AmpGen is located at the git repository [github.com/GooFit/AmpGen](github.com/GooFit/AmpGen). Throughout these lessons we will be using lxplus at CERN as the host machine for AmpGen but AmpGen can be built if you meet the requirements (which most Macs and Linux distros can). Bare in mind that AmpGen is very CPU intensive and will use all of the resources it can get - this is particularly the case with CPU cache which most laptops have less of. 

First clone AmpGen into a directory of your choosing, throughout these lessons, the directory `/afs/cern.ch/work/${USER::1}/$USER/sw/AmpGen` will be used (note that `$USER` is a bash variable for your username and `${USER::1}` gets the first character of your username), i.e. your user space in the "work" afs location, e.g. `/afs/cern.ch/work/j/jolane/sw/AmpGen`, if you copy and paste the code below, you will see a directory /`afs/cern.ch/work/${USER::1}/$USER/sw/AmpGen`.


Make the `sw` directory
~~~
mkdir -p /afs/cern.ch/work/${USER::1}/$USER/sw/
~~~

change to the `sw` directory 

~~~
cd /afs/cern.ch/work/${USER::1}/$USER/sw
~~~

clone `AmpGen` into your directory

~~~
git clone --recursive github.com/GooFit/AmpGen
~~~

change to the `AmpGen` directory

~~~
cd AmpGen
~~~

this will put you in the AmpGen directory. Let's set the location of AmpGen as the `AMPGENROOT` bash variable

~~~
export AMPGENROOT=/afs/cern.ch/work/${USER::1}/$USER/sw/AmpGen
~~~

this will make our life a bit easier, if you use a different location for AmpGen simply change the variable to the appropriate location.

Installing AmpGen
-----------------

`AmpGen` uses `CMake` to manage the building  of its libraries and executables. In `lxplus` we need to get a more recent version of `CMake` and `gcc` than the default when we login

~~~
cmake --version
~~~

~~~
cmake version 3.11.0`
CMake suite maintained and supported by Kitware (kitware.com/cmake)
~~~

~~~
gcc --version
~~~

~~~
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
~~~
We need `CMake 3.13` and `gcc 8.x` , which we can get using the prefixes available at `lxplus`

~~~
source /cvmfs/sft.cern.ch/lcg/views/setupViews.sh  LCG_94python3 x86_64-centos7-gcc8-opt
~~~

which should give you 
~~~
cmake --version
~~~

~~~
cmake version 3.11.1
CMake suite maintained and supported by Kitware (kitware.com/cmake)
~~~

~~~
gcc --version
~~~

~~~
gcc (GCC) 8.3.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
~~~

now we can build `AmpGen`, we will install `AmpGen` to `$AMPGENROOT/install`


Make our installation directory
~~~
mkdir -p $AMPGENROOT/install
~~~
Go to the installation directory
~~~
cd $AMPGENROOT/install
~~~
Setup the CMake environment
~~~
cmake --DCMAKE_CXX_STANDARD=17 ..
~~~
If there are no errors (warnings are fine!) we will have a Makefile which will automatically compile everything in `$AMPGENROOT/{apps,test,example}`
On lxplus we use 10 threads to make but as a rule of thumb - use the number of cores on your machine
~~~
make -j10
~~~

If everything has gone right we will have our `AmpGen` programs in `$AMPGENROOT/install/bin`
~~~
ls $AMPGENROOT/install/bin
~~~
~~~
ampgen.py, belle.opt, belleQC.opt, ConvertToSourceCode, D02Kpipipi.opt, D02piKpipi.opt, DataConverter, Dbar02piKpipi.opt, Debugger, DtoKKpipi_v2.opt, example_b2kstarll.opt,
example_glass.opt, example_kmatrix.opt, example_kspipi.opt, example_lc.opt, example_purelyBaronic.opt, example_radiative.opt, Fitter, FitterExample.opt, FitterWithPolarisation, Generator,
kMatrix.opt, mass_width.csv, MintDalitzSpecialParticles.csv, pdgID_to_latex.dat, QcFitter, QcGenerator, qc_options_example.opt, QcProjections, SignalOnlyFitter, SimFit, test_CorrelatedSum,
timBelle.opt
~~~

For our convienence let's add `$AMPGENROOT/install/bin` to the `$PATH` variable, so we can execute these programs in any directory

~~~
export PATH=$AMPGENROOT/install/bin:$PATH
~~~

Now we have everything we need to run `AmpGen` programs in any directory.

The purpose of these "lessons"
---

In these "lessons" we will go through the basic usage of `AmpGen`'s available programs, examine the way `AmpGen` can build your amplitude model and some more experimental aspects of `AmpGen`, in particular the "Quantum Correlated" abilities of `AmpGen`. 