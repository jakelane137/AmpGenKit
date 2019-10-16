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

AmpGen (currently) only runs on CPUs (via OpenMP) thus if your heart is set on using GPUs for compute, GooFit - a portmanteau of GPU and RooFit - may be for you. AmpGen shares a repository with GooFit.

Getting AmpGen
--------------

AmpGen is located at the git repository github.com/GooFit/AmpGen. Throughout these lessons we will be using lxplus at CERN as the host machine for AmpGen but AmpGen can be built if you meet the requirements (which most Macs and Linux distros can). Bare in mind that AmpGen is very CPU intensive and will use all of the resources it can get - this is particularly the case with CPU cache which most laptops have less of. 

First clone AmpGen into a directory of your choosing, throughout these lessons, the directory /afs/cern.ch/work/${USER::1}/$USER/sw/AmpGen will be used 

mkdir -p /afs/cern.ch/work/${USER::1}/$USER/sw/
cd /afs/cern.ch/work/${USER::1}/$USER/sw
git clone --recursive github.com/GooFit/AmpGen
cd AmpGen

this will put you 
