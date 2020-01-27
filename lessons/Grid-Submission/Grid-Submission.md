Submitting AmpGen jobs to the GRID
===

We've seen how to use the Batch system at CERN, but we may want to use the World Wide Computing Grid (WWCG) with CERN instead.

Initial Requirements
---

Let's make sure we have GRID credentials, 
```dirac-proxy-init```

Then we need to write a job submission script (in python) for `Ganga` to use

```
j = Job()
j.application.exe = File("batch_script.sh")
j.backend = Dirac()
j.submit()
```

this basic job will take any "batch_script.sh" that we used in the Batch system. This way we have a nice and easy way to move from a small testing area (the batch submission system) to a larger production system (the WWCG).

