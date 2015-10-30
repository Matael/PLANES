General information
===================

PLANES relies on a set of Matlab scripts and is completly open-source.

This tool provides several methods of discretisation for fields and several types of resolution strategies which are
listed below.

Methods of discretisation
~~~~~~~~~~~~~~~~~~~~~~~~~

- 3 Nodes Triangles (TR3)
- 6 Nodes Triangles (TR6)
- Triangle with Hermite interpolation (H12)

Resolution strategies
~~~~~~~~~~~~~~~~~~~~~

- Finite Element Method (FEM)
- Discontinuous Galerkin Method (DGM)
- Plane Waves for multilayer systems

Material models
~~~~~~~~~~~~~~~

As the main goal of this softare is to provide an easy-to-configure, reliable way to model and resolve complex systems
involving porous materials it's possible to identifying all those different materials/aproximation :

- air
- equivalent elastic solid
- equivalent fluid
- limp model
- Biot model (1998 formulation)
- Biot model (2001 formulation)
- PML

It is, of course, possible to specify periodicity conditions (for code-simplicity sake, periodicity must be defined on
compatible boundaries).

Methods Coupling
----------------

Through its quite simple code base and its script-based architecture, PLANES is really flexible and is sometimes used to
experiment new techniques. The experimentation on FEM & DGM coupling leaded to the introduction of method coupling
abilities.

It's therefore possible to couple FEM & DGM methods, using compatible or incompatible meshes.


