Getting Started
===============

Get the code
------------

As PLANES is in continuous development, the only available version today is on Github_.

You can either download the lastest version as a `zip file here`_ or get it through Git_ to stay on the cutting edge ::

    $ git clone https://github.com/OlivierDAZEL/PLANES

Understanding architecture
--------------------------

In the ``src/`` folder, you'll find all the scripts, the folders inside ``src/`` have self-explanatory names :

``FEM/`` & ``DGM/`` & ``PW/``
    Implementation of Finite Elements & Discontinuous Galerkin Methods, Plane wave based methods (multilayer)

``Material/`` & ``Physics/``
    Material properties & modelling

``Mesh/``
    Mesh management routines (reading, modification, tagging, etc...)

``Plots/``
    Output functions

``Polynomials/``
    Function to combine, derive, integrate, etc.. polynomials

``Problems/`` & ``Solutions/``
    Directory for m-files describing configurations & analytical solutions of problems (legacy)


The most important for you will be ``src/Main``.
This folder contains the main routines, ``PLANES_main.m`` for legacy projects & ``PLANES.m`` [#]_ for newer,
separate-directory projects.

Other files are initialization, logging and postprocessing routines.

Creating a new project
----------------------

.. note:: The following section only discuss separate-directory projects.

To start a new project, create a directory separated from the ``src/`` directory of PLANES (your dir may be anywhere on
the file system) and create a ``project_info.m`` file inside ::

    $ mkdir /home/you/MyPLANESProject/
    $ cd /home/you/MyPLANESProject
    $ touch project_info.m

.. tip:: You can consider a project as a global experiment. The next step is therefore to specify the different
    configurations for the experiment. If one wants for example to test reflection on a porous material set behind a
    membrane, it may be interesting to try different parameters for the membrane : all the configurations are about the
    same experiment, thus in the same project dir. Configurations are identified by appending an underscore (``_``) and
    a number at the end of m-file and .edp.


.. [#] Which contains the ``PLANES()`` function.

.. _github: https://github.com/OlivierDAZEL/PLANES
.. _git: https://git-scm.com
.. _zip file here: https://github.com/OlivierDAZEL/PLANES/archive/master.zip

