with Interfaces.C.Extensions;
with MagickWand;
with MagickWand.Image; use MagickWand.Image;
with Ada.Text_IO; use Ada;

with Interfaces.C.Strings;

procedure Exampl is
   use Interfaces.C;
   use Interfaces.C.Strings;
   use MagickWand;
   Wand : Magick_Wand;
   Half_Width  : Image.Size;
   Half_Height : Image.Size;
begin
   MagickWandGenesis;
   Wand := NewMagickWand;
   if Image.MagickReadImage
     (Wand, New_Char_Array ("adapowered.jpg")) = MagickTrue
   then
      Half_Width  := MagickGetImageWidth (Wand) / 2;
      Half_Height := MagickGetImageHeight (Wand) / 2;

      if MagickResizeImage
        (Wand, Half_Width, Half_Height, LanczosFilter, 1.0) = MagickTrue
        and then Image.MagickSetImageCompressionQuality
          (Wand, 100) = MagickTrue
        and then MagickWriteImage
          (Wand,
           Interfaces.C.Strings.New_Char_Array ("res.jpg")) = MagickTrue
      then
         Ada.Text_IO.Put_Line ("ok. res.jpg has been created");
      end if;
   end if;

   Wand := DestroyMagickWand (Wand);
   MagickWandTerminus;
end Exampl;
