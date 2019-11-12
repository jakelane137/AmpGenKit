Amplitudes
=========

`AmpGen`, as the name suggests, builds everything from "Amplitudes", $`A(\mathcal{P})`$ for multi-body decays that occupy some phasespace, $`\mathcal{P}`$. 

Let's begin with a well known 3 body decay, $`D^0 \to K_S^0 \pi^+ \pi^-`$, which has many possible models to describe it. 

Partial Wave
------------

An amplitude in Ampgen can be described in many different ways, in these lessons we focus on the "Coherent Sum" approach, that is our Amplitude for a decay will be of the form
```math
A(z) = \sum_i a_i A_i(z)
```
where $`z`$ is the position in the phase-space $`\mathcal{P}`$ of the decay and $`a_i`$ is the complex coupling to the individual amplitude $`A_i`$ which we call a "partial-wave".

These partial waves can be factorised into four components

```math
A_i = F_X F_r Z_L T_r
```
where $`F_(X,r)`$ is the mother, resonance respectively. The "barrier factors", $`F`$ describe the production and decay of a resonance - these are known as "modifiers" to AmpGen, they are specified by the options
```
Lineshapes::DefaultModifier BW
```
which is usually a Blatt-Weiskopf factor (BW). 

The "lineshape", $`T`$, is (by default) a relativistic Breit Wigner shape for a two body resonance. 

The "spin density" factor $`Z`$, describes the angular dependence of the partial wave - therefore one must specify a "formalism" as to how angles are to be interperated. 

Options file
------------
`AmpGen` will take an "options" file as an input for all of its programs. The main purpose of this options file is to describe every amplitude that we want to construct.
In our $`D^0 \to K_S^0 \pi^+ \pi^-`$ example we will start with a "flat" amplitude, we will call the options file "flat.opt"

```
EventType D0 K0S0 pi+ pi-
D0{K0S0,pi+,pi-} Fix 1 0 Fix 0 0
```

In the options file, one has the 
    - name of the decay (in a format that `AmpGen` can recognise)
    - The complex coupling to the amplitude

One can work in either "cartesian" or "polar" coordinates for the components of the complex coupling

By default `AmpGen` works in "cartesian coordinates", so for our simple options file we have just set the coupling to the flat component to $`(1 \pm 0) + (0 \pm 0) i`$.

The syntax for a decay, $`X \to a b c`$ is given as `X{a,b,c}`, for intermediate decays, $`X \to a b ( \to c d)`$ is written as `X{a,b{c,d}}`

Coordinate Systems
------------------

To specify a coordinate system use the option
```
CouplingConstant::CoordinateSystem
```
which can have "cartesian" (default) or "polar",
e.g

```
CouplingConstant::CoordinateSystem cartesian
D0{K0S0,pi+,pi-} Free 1 0.01 Free -0.5 0.01
```

sets the coupling constant to the flat $`D^0 \to K_S^0 \pi^+ \pi^-`$ decay to $`(1\pm 0.01) + (-0.5 \pm 0.01)$`

whereas 

```
CouplingConstant::CoordinateSystem polar
CouplingConstant::AngularUnits rad
D0{K0S),pi,pi-} Free 2 0.01 Free 0.5 0.01
```

set the coupling constant to the flat $`D^0 \to K_S^0 \pi^+ \pi^-`$ decay to $`(2 \pm 0.01) e^{i (0.5 \pm 0.01)}$`.

To use degrees, simply change the option

```
CouplingConstant::AngularUnits rad
``` 
to 

```
CouplingConstant::AngularUnits deg
``` 

Lineshapes
----------

Each partial wave in an amplitude may be described by a different "lineshape", e.g Breit-Wigner, Gournaris-Sakurai, LASS, K-Matrix, FOCUS, etc. 
AmpGen will use the "Breit-Wigner" lineshape by default, but to specify a specific lineshape for a componenet, use the `[]` after the name.
For example, in $`D^0 \to K_S^0 \pi^+ \pi^-`$, we will want to use the "LASS" lineshape for the $`K_S^0 \pi^\pm`$ S-wave. 
To do this in AmpGen we write in the options file
```
CouplingConstant::Coordinates polar
D0{K(0)*(1430)bar-[GLASS]{K0S0,pi-},pi+} Free 0.196005885344012 0.001056344750514 Free -1.43981739504892 0.006201212128016
```
which sets a "LASS" lineshape with the coupling $`(0.196 \pm 0.001) e^{i(-1.440 \pm 0.006)}`$ for the $`K_S^0 \pi^-`$ S-wave.
To modify the parameters of the lineshape itself 

```
K(0)*(1430)bar-::GLASS::a 2              0.11267        0.01
K(0)*(1430)bar-::GLASS::r  2              -33.799        0.01
K(0)*(1430)bar-::GLASS::F 2              0.95532        0.01
K(0)*(1430)bar-::GLASS::phiF 2              0.00173        0.01
K(0)*(1430)bar-::GLASS::R   3 1 0
K(0)*(1430)bar-::GLASS::phiR 2               -1.9145        0.01
```
which sets the parameters $`a,r,F,\phi_F,R,\phi_R`$ from the LASS parameterisation. 



Spin Formalism
--------------

AmpGen has two methods to describe the spin-density of the partial wave of an Amplitude. AmpGen currently has two options for this `covariant` and `canonical`.
The `covariant` spin formalism uses the Rarita-Schwinger formalism, whereas the `cannonical` formalism uses the helicity of the particles. 
One can change the spin formalism for all decays by using
```
Particle::SpinFormalism cannonical
```
or for a single component

```
D0[SpinFormalism=Canonical]{K*(892)bar-,pi+} ...
```

Particle Proprties
------------------

The mass, width and radius of any particle can be changed by specifying 
```
X_mass
X_width
X_radius
```
where $`X`$ is the name of the particle

e.g. 

```
D0_mass Fix 1.864 0.0001
```
where we can fix or free parameters with a step size as with complex couplings. Note that freeing these components can slow down the time it takes to fit data, depending on what needs to be recalculated, typically one fixes these parameters. AmpGen uses the PDG values for the particles it can describe.



