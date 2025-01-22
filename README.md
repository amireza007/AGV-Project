# My Master's thesis
This repo is the implementation of my thesis, which is mostly the implementation of [*A branch-and-bound approach for AGV dispatching and routing problems in automated container terminal*](https://doi.org/10.1016/j.cie.2022.107968)]s* by Z. Wang and Q. Zeng.

- It used a customized *Branch and Bound (B&B)* approach to solve the conflict-free scheduling of AGVs and dispatching Containers in and ACT. 
- The article assumes a **bidirectional layout** meaning the horizontal and vertical shortcut between the yard area and quay area. This assumption is very important and interesting and novel, since it can considerably increase the conflict but it can be cost-efficient to use this layout.
- The full description of the article and algorithm is in my github.io page (blog's address: https://amireza007.github.io/posts/MSThesis/)

## My contribution:
I intend to modify the implemented B&B to be parallel. Additionally, the article do not consider QC allocation to each ship, which might be useful to consider a more integrated scenario.

## Implementation:
- I firstly wrote the Mixed Integer Programming (MIP) model into GAMS, (_which is a horrible unconventional  modeling language but efficient at constructing the model, according to [GAMS site](https://www.gams.com/blog/2023/07/performance-in-optimization-models-a-comparative-analysis-of-gams-pyomo-gurobipy-and-jump/)_). The file `BBAPP.gms` (located in 'Thesis/Implementation') could be used to run the code using **Gurobi** solver from [neos-server.org](https://neos-server.org/neos/)
  - The Model in the gams code consists of **41** blocks of constraints, categorized into 4 main groups, namely *Job assignment, Location based constraints, Time based and conflict avoidance contraints*

- I would be using QT and C++ to implement the article. In this way, I can integrate CUDA api to test it in a parallel-fashion.