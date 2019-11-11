Fitting with AmpGen
===================

Now that we can generate events with `AmpGen`, we can fit these events with a given model. `AmpGen` offers a few fitting programs, for simplicity we will use the simplest one, `SignalOnlyFitter` which (as the name suggests) only fits "Signal" events (as opposed to "Signal + Background" which we see in real experiments).

`SignalOnlyFitter` uses the arguments
    - "--DataSample" , the input data sample
    - "--IntegrationSample" (optional), a set of events (in the same format as the data sample) used to normalise the fitting pdf and to produce projections
    - "--EventType", as with `Generator` `AmpGen` needs to know what type of decay is being used
    - "--Plots", the location for the `ROOT` file that contains the projections of the fit
    - "--LogFile", the location for the "logfile" that contains the results of the fit (including the values of the fitted parameters and their covariance matrix, the fit quality, fit fractions and $`\chi^2`$)

If one does not provide an integration sample to `SignalOnlyFitter`, `AmpGen` will generate one for us, but we will generate a flat sample since it is very quick and it allows us to control the size of the integration sample.

the command 

`Generator --nEvents 1000000 --EventType "D0 K0S0 pi- pi+ --Output flat.root --Seed $RANDOM flat.opt"`
will generate our "flat" integration sample with 1000000 events

We will generate our data sample with `Generator` 

``Generator --nEvents 10000 --EventType "D0 K0S0 pi- pi+" --Output data.root --Seed $RANDOM data.opt``

then to fit our data with our model

``SignalOnlyFitter --Seed $RANDOM --EventType "D0 K0S0 pi- pi+"" Plots plots.root --LogFile fit.log --DataSample data.root --IntegrationSample flat.root model.opt``

this will fit ``data.root`` with our ``model.opt`` values and output the fit log to ``fit.log`` and the projections to ``plots.root``
