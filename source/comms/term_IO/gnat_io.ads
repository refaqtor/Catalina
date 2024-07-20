-------------------------------------------------------------------------------
--             This file is part of the Ada Terminal Emulator                --
--               (Terminal_Emulator, Term_IO and Redirect)                   --
--                               package                                     --
--                                                                           --
--                             Version 2.0                                   --
--                                                                           --
--                   Copyright (C) 2003 Ross Higson                          --
--                                                                           --
-- The Ada Terminal Emulator package is free software; you can redistribute  --
-- it and/or modify it under the terms of the GNU General Public License as  --
-- published by the Free Software Foundation; either version 2 of the        --
-- License, or (at your option) any later version.                           --
--                                                                           --
-- The Ada Terminal Emulator package is distributed in the hope that it will --
-- be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General --
-- Public License for more details.                                          --
--                                                                           --
-- You should have received a copy of the GNU General Public License along   --
-- with the Ada Terminal Emulator package - see file COPYING; if not, write  --
-- to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,       --
-- Boston, MA  02111-1307, USA.                                              --
-------------------------------------------------------------------------------

with Term_Io;
pragma Elaborate_All (Term_Io);

package Gnat_Io is

   subtype File_Type is Term_Io.File_Type;
   --  Specifies file to be used (the only possibilities are Standard_Output
   --  and Standard_Error). There is no Create or Open facility that would
   --  allow more general use of file names.

   function Standard_Output return File_Type;
   function Standard_Error return File_Type;
   --  These functions are the only way to get File_Type values

   procedure Get (
         X :    out Integer );
   procedure Get (
         C :    out Character );
   procedure Get_Line (
         Item : in out String;
         Last :    out Natural );
   --  These routines always read from Standard_Input

   procedure Put (
         File : File_Type;
         X    : Integer    );
   procedure Put (
         X : Integer );
   --  Output integer to specified file, or to current output file, same
   --  output as if Ada.Text_IO.Integer_IO had been instantiated for Integer.

   procedure Put (
         File : File_Type;
         C    : Character  );
   procedure Put (
         C : Character );
   --  Output character to specified file, or to current output file

   procedure Put (
         File : File_Type;
         S    : String     );
   procedure Put (
         S : String );
   --  Output string to specified file, or to current output file

   procedure Put_Line (
         File : File_Type;
         S    : String     );
   procedure Put_Line (
         S : String );
   --  Output string followed by new line to specified file, or to
   --  current output file.

   procedure New_Line (
         File    : File_Type;
         Spacing : Positive  := 1 );
   procedure New_Line (
         Spacing : Positive := 1 );
   --  Output new line character to specified file, or to current output file

   procedure Set_Output (
         File : File_Type );
   --  Set current output file, default is Standard_Output if no call to
   --  Set_Output is made.

end Gnat_Io;
