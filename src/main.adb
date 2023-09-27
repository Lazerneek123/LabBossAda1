with Ada.Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;


procedure Main is
   type IntVector is array (Positive range <>) of Integer;
   Count_Wave : Integer := 1;

   package Data_Vectors is new Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);
   use Data_Vectors;
   Vector_Data : Data_Vectors.Vector;

   task type Task_Wave is
      entry Start;
   end Task_Wave;

   task body Task_Wave is
   function Sum (Num1, Num2 : Integer) return Integer is
   begin
         Ada.Text_IO.Put_Line (Integer'Image (Num1) & " + " & Integer'Image (Num2));
         return Num1 + Num2;
      end Sum;
      Result : Data_Vectors.Vector;
      sum1 : Integer;

   begin

      accept Start do
         Ada.Text_IO.Put_Line ("Wave: " & Integer'Image (Count_Wave));
         Count_Wave := Count_Wave + 1;

         for I in 1 .. (Integer(Vector_Data.Length) + 1) / 2 loop
          if Integer(Vector_Data.Length) = 1 then
            Result.Append(Vector_Data.First_Element);
            Vector_Data.Delete_First;
          else
             sum1 := Sum(Vector_Data.First_Element, Vector_Data.Last_Element);
             Result.Append(sum1);
             Vector_Data.Delete_First;
             Vector_Data.Delete_Last;
            end if;
       end loop;
         Vector_Data := Result;
         Put_Line (Data_Vectors.Vector'Image (Vector_Data));
         Result.Clear;

      end Start;

   end Task_Wave;

   Task1 : Task_Wave;
   Task2 : Task_Wave;
   Task3 : Task_Wave;


begin
   for I in 1 .. 6 loop
      Vector_Data.Append(I);
   end loop;

     Task1.Start;
     Task2.Start;
     Task3.Start;

end Main;