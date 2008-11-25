
with Interfaces.C;
with System;

package MagickWand is

   use Interfaces.C;

   MaxTextExtent : constant := 4096;
   --  wand/MagickWand.h:132

   subtype MagickBooleanType is Unsigned;
   MagickFalse : constant MagickBooleanType := 0;
   MagickTrue  : constant MagickBooleanType := 1;
   -- ./magick/magick-type.h:175:3

   type Magick_Wand is private;

   function DestroyMagickWand (Wand : Magick_Wand) return Magick_Wand;
   pragma Import (C, DestroyMagickWand, "DestroyMagickWand");
   -- wand/MagickWand.h:183:4

   function NewMagickWand return Magick_Wand;
   pragma Import (C, NewMagickWand, "NewMagickWand");
   -- wand/MagickWand.h:184:4

   procedure MagickWandGenesis;
   pragma Import (C, MagickWandGenesis, "MagickWandGenesis");
   -- wand/MagickWand.h:189:3

   procedure MagickWandTerminus;
   pragma Import (C, MagickWandTerminus, "MagickWandTerminus");
   -- wand/MagickWand.h:190:3

   function CloneMagickWand (Wand : Magick_Wand) return Magick_Wand;
   pragma Import (C, CloneMagickWand, "CloneMagickWand");
   -- wand/MagickWand.h:182:4

private
   type Magick_Wand is new System.Address;
end MagickWand;
