Amplitudes
=========

`AmpGen`, as the name suggests, builds everything from "Amplitudes", $`A(\mathcal{P})`$ for multi-body decays that occupy some phasespace, $`\mathcal{P}`$. 

Let's begin with a well known 3 body decay, `$D^0 \to K_S^0 \pi^+ \pi^-$`, which has many possible models to describe it. 


Options file
------------
`AmpGen` will take an "options" file as an input for all of its programs. The main purpose of this options file is to describe every amplitude that we want to construct.
In our `$D^0 \to K_S^0 \pi^+ \pi^-$` example we will start with a "flat" amplitude, we will call the options file "flat.opt"

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
