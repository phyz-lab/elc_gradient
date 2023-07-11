ELC_gradient
==============================

Using gradient-based techniques to find optimal stimulus waveform for neuronal activation.

Project Organization
------------

    ├── README.md          
    │
    ├── FitzHugh-Nagumo/    
    │   ├── Initiating Repetitive Firing/
    |   │   ├── fhn.m - Function describing the FitzHugh-Nagumo equations
    |   │   ├── gradAlg.m - This is the gradient algorithm for a single run with a given initial and terminal condition.
    |   │   ├── optInOut.m - This is the main program to run used to process every single run between the quiescent state and every single point on the repetitive firing limit cycle.
    |   │   ├── outX.mat - A set of 68 points defining the repetitive firing limit cycle.
    |   │   ├── pInfluence.m - Function describing the p influence equations
    |   │   └── RInfluence.m - Function describing the R influence equations
    │   │
    │   └── Suppressing Repetitive Firing/
    |       ├── fhn.m - Function describing the FitzHugh-Nagumo equations
    |       ├── gradAlg.m - This is the gradient algorithm for a single run with a given initial and terminal condition.
    |       ├── optOutIn.m - This is the main program to run used to process every single run between every single point on the repetitive firing limit cycle and the quiescent state.
    |       ├── outX.mat - A set of 68 points defining the repetitive firing limit cycle.
    |       ├── pInfluence.m - Function describing the p influence equations
    |       └── RInfluence.m - Function describing the R influence equations
    │  
    └── Hodgkin-Huxley/
        ├── gradAlg.m - This is the main program to run.
        ├── hh.m - Function describe the Hodgkin-Huxley equations
        ├── pInfluence.m - Function describing the p influence equations
        └── RInfluence.m - Function descibring the R influence equations 

 
