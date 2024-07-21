Overview
--------

Catalina is an ANSI C compiler, plus C libraries and various utilities, for the Parallax Propeller family of microcontrollers. 

Catalina supports both internal and external memory models on both the Propeller 1 and 2, for program sizes up to 16Mb.

Catalina runs under Windows, Linux and also its own self-hosted development enviroment (**catalyst**).

Catalina supports command-line use (Windows, Linux and Catalyst) and an Integrated Development Environment based on Geany (Windows and Linux).

Catalina supports the Lua scripting language, both stand-alone and embedded.

Catalina supports multi-threaded, multi-processor and multi-model programming. Catalina supports lightweight threads as well as Posix threads and Lua threads.

The main components of Catalina are:

-  **catalina**    : C compiler (Windows, Linux and Catalyst)
-  **catalyst**    : SD card based program loader and self-hosted development environment
-  **catalina_geany** : Integrated Development Environment (Windows and Linux)
-  **payload**     : Serial program loader and simple terminal emulator (Windows and Linux)
-  **comms**       : Full-featured VT100 terminal emulator (Windows only)
-  **blackbox**    : C source level debugger (Windows and Linux)
-  **catapult**    : Utility for building multi-model C programs (Windows and Linux)
-  **parallelize** : Utility for building multi-processor C programs (Windows and Linux)
-  **spinnaker**   : Propeller 1 Spin compiler and assembler (Windows and Linux)
-  **p2asm**       : Propeller 2 assembler (Windows, Linux and Catalyst)

Setting up Catalina 
-------------------

Windows using Setup
-------------------
If you used a Windows Installer package (e.g. **Catalina_7.6.3_Setup.exe**) to install Catalina, the Windows Start Menu should contain the following shortcuts:

-   **Catalina Command Line** : Start a Windows command shell (i.e. cmd.exe) in the Catalina directory and set up the Catalina environment variables and paths.
-   **Catalina Geany** : Start the Catalina version of the Geany Integrated Development Environment.
-   **Documents** : Contains links to Catalina tutorial and reference documents.

Windows Manual install
----------------------

If you did not use the Windows Setup package but either cloned the Git repository or downloaded it as a compressed file and then uncompressed it, then the distribution includes binaries suitable for Windows 10 or Windows 11, but you must set it up manually. 
    
Open a Windows command shell (i.e. **cmd.exe**), then **cd** to the Catalina installation folder. Then execute the command **use_catalina** to set up the Catalina environment variables and paths. Then you can either use Catalina directly from the command line, or use the command **catalina_geany** to start the Catalina Geany Integrated Deveopment Environment. The Catalina documents are available in the **Documents** folder.

To create Windows Start Menu entries, open a Windows command shell (i.e. **cmd.exe**) with Administrator privileges, then **cd** to the Catalina installation folder. Then execute the command **catalina_shortcuts** optionally specifying the name of the Start Menu entry to create (in quotes). For example: **catalina_shortcuts "Catalina 7.6.3"**

Linux Precompiled Package
-------------------------

If you downloaded a Linux release package (e.g. **Catalina_7.6.3_Linux.tar.gz**) then the package will contain executables built for a recent Ubuntu release (currently Ubuntu version 23). Simply open a Terminal window, **cd** to the directory where you installed Catalina and enter (note the back quotes):
**export LCCDIR=\`pwd\`**
**source use_catalina**
Then you can either use Catalina directly from the command-line or enter **catalina_geany** to use the Catalina Geany IDE. 
However, if the pre-built Catalina executables do not work on your Linux installation, refer to the next section on installing it manually.

Linux Manual Install
--------------------
If you cloned the Git repository or downloaded it as a compressed file and then uncompressed it then you must always rebuild Catalina from source. Follow the Linux instructions in the **BUILD.TXT** document in the main Catalina installation folder to build Catalina. This document also contains instructions on setting Catalina up for use.

More Information
----------------
The documents **Getting Started with Catalina** and **Getting Started with the Catalina Geany IDE** for tutorial information on using Catalina.

See the other Catalina documents for more detailed information on various Catalina components.

