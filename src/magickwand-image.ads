with Interfaces.C.Strings;

package MagickWand.Image is

   subtype FilterTypes is Unsigned;
   UndefinedFilter : constant FilterTypes := 0;
   PointFilter     : constant FilterTypes := 1;
   BoxFilter       : constant FilterTypes := 2;
   TriangleFilter  : constant FilterTypes := 3;
   HermiteFilter   : constant FilterTypes := 4;
   HanningFilter   : constant FilterTypes := 5;
   HammingFilter   : constant FilterTypes := 6;
   BlackmanFilter  : constant FilterTypes := 7;
   GaussianFilter  : constant FilterTypes := 8;
   QuadraticFilter : constant FilterTypes := 9;
   CubicFilter     : constant FilterTypes := 10;
   CatromFilter    : constant FilterTypes := 11;
   MitchellFilter  : constant FilterTypes := 12;
   LanczosFilter   : constant FilterTypes := 13;
   BesselFilter    : constant FilterTypes := 14;
   SincFilter      : constant FilterTypes := 15;
   KaiserFilter    : constant FilterTypes := 16;
   WelshFilter     : constant FilterTypes := 17;
   ParzenFilter    : constant FilterTypes := 18;
   LagrangeFilter  : constant FilterTypes := 19;
   BohmanFilter    : constant FilterTypes := 20;
   BartlettFilter  : constant FilterTypes := 21;
   SentinelFilter  : constant FilterTypes := 22;
   -- ./magick/resample.h:52:3

   type Size is new Unsigned_Long;

   function MagickReadImage
     (Wand     : Magick_Wand;
      Filename : Interfaces.C.Strings.Chars_Ptr)
      return MagickBooleanType;
   pragma Import (C, MagickReadImage, "MagickReadImage");
   -- ./wand/magick-image.h:224:3

   function MagickResizeImage
     (Wand   : Magick_Wand;
      Width  : Size;
      Height : Size;
      Filter : FilterTypes;
      Blur   : Double) return MagickBooleanType;
   pragma Import (C, MagickResizeImage, "MagickResizeImage");
   -- ./wand/magick-image.h:233:3

   function MagickGetImageWidth (Wand : Magick_Wand) return Size;
   pragma Import (C, MagickGetImageWidth, "MagickGetImageWidth");
   -- ./wand/magick-image.h:390:3

   function MagickGetImageHeight (Wand : Magick_Wand) return Size;
   pragma Import (C, MagickGetImageHeight, "MagickGetImageHeight");
   -- ./wand/magick-image.h:386:3

   function MagickSetImageCompressionQuality
     (Wand : Magick_Wand; Quality : Unsigned_Long) return MagickBooleanType;
   pragma Import (C, MagickSetImageCompressionQuality,
                  "MagickSetImageCompressionQuality");
   -- ./wand/magick-image.h:260:3

   function MagickWriteImage
     (Wand     : Magick_Wand;
      Filename : Interfaces.C.Strings.Chars_Ptr) return MagickBooleanType;
   pragma Import (C, MagickWriteImage, "MagickWriteImage");
   -- ./wand/magick-image.h:326:3

end MagickWand.Image;

