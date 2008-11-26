
with MagickWand;
with Ada.Text_IO; use Ada;

procedure Test is
   use type MagickWand.Size;

   Image : MagickWand.Object;
   Half_Width  : MagickWand.Size;
   Half_Height : MagickWand.Size;
begin
   MagickWand.Genesis;
   Image.Read ("adapowered.jpg");


   Half_Width  := Image.Get_Width / 2;
   Half_Height := Image.Get_Height / 2;

   Image.Set_Filename ("res.jpg");

   Image.Resize (Half_Width, Half_Height, Magickwand.LanczosFilter, 1.0);

   Image.Set_Compression_Quality (100.0);

   Image.Write (Image.Get_Filename);

   --  Ok. Image should be created.
   Ada.Text_IO.Put_Line ("ok. res.jpg has been created");

   MagickWand.Terminus;

end Test;
