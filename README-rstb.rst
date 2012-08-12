Rstb
====

NAME
----

    rstb - manage a plain text blog

SYNOPSYS
--------

    rstb new <name>
    rstb edit <file>
    rstb build <file>
    rstb view <file>
    rstb publish <file>
    rstb cmd ...

DESCRIPTION
-----------

Configuration
+++++++++++++

Configuration files:

- /etc/rstbrc
- /usr/local/etc/rstbrc
- ~/.rstbrc

These files are sourced as bash scripts, so be careful. Any code you put in
there will be run as normal code.

Variables 
~~~~~~~~~

``posts_directory``:
    Root of the blog. This directory will serve as the storage point for all
    the posts. Make sure you have write permissions.

New
+++

To create a new post, just type:

    rstb new <name>

where <name> is the name of the post, for example:

    rstb new what-a-wonderful-world

The previous command will create a post in ``posts_directory``. If you don't
commit the changes you do in your editor, the entry will not be saved. See the
section on Edit_ for more details on the editing. 

Edit
++++

To edit an existing post, type:

    rstb edit <file>

where <file> is the whole path to the file created. I did a bash completion
script to ease with the typing:

- https://github.com/dualbus/bashcomp/blob/master/bashcomp/rstb

I'm not getting into the details of installing it though.


You can create a bash function in the rstbrc file to override the editor. The
file will be the first argument to the function. For example, this one will
open the file in ``gedit``:

.. code:: bash

   editor() { gedit "$1" </dev/null >&0 2>&1 & disown; }

Or just set the EDITOR environment variable, since rstb will try to use your
default editor (or fall-back to vim, I should probably make that vi).

Build
+++++

- lazy

PROBLEMS
--------

- Many

SEE ALSO
--------

- Foo
- Bar
