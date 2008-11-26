
with Interfaces.C.Strings;

package body MagickWand is

   use Interfaces.C;
   use Interfaces.C.Strings;

   -----------
   -- Clone --
   -----------

   function Clone (O : Object) return Object is
      function CloneMagickWand (Wand : System.Address) return System.Address;
      pragma Import (C, CloneMagickWand, "CloneMagickWand");
      -- wand/MagickWand.h:182:4

   begin
      return Cloned_Object : Object do
         Cloned_Object.Wand := CloneMagickWand (O.Wand);
      end return;
   end Clone;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize   (O : in out Object) is
      function DestroyMagickWand
        (Wand : System.Address) return System.Address;
      pragma Import (C, DestroyMagickWand, "DestroyMagickWand");
      -- wand/MagickWand.h:183:4
   begin
      O.Wand := DestroyMagickWand (O.Wand);
   end Finalize;

   ------------------
   -- Get_Filename --
   ------------------

   function Get_Filename (O : Object) return String is
      function MagickGetImageFilename
        (Wand     : System.Address) return Interfaces.C.Strings.Chars_Ptr;
      -- ./wand/magick-image.h:264:3
      pragma Import (C, MagickGetImageFilename, "MagickGetImageFilename");
   begin
      return Strings.Value (MagickGetImageFilename (O.Wand));
   end Get_Filename;

   ----------------
   -- Get_Height --
   ----------------

   function Get_Height (O : Object) return Size is
      function MagickGetImageHeight (Wand : System.Address) return Size;
      pragma Import (C, MagickGetImageHeight, "MagickGetImageHeight");
      -- ./wand/magick-image.h:386:3
   begin
      return MagickGetImageHeight (O.Wand);
   end Get_Height;

   ---------------
   -- Get_Width --
   ---------------

   function Get_Width (O : Object) return Size is
      function MagickGetImageWidth (Wand : System.Address) return Size;
      pragma Import (C, MagickGetImageWidth, "MagickGetImageWidth");
      -- ./wand/magick-image.h:390:3
   begin
      return MagickGetImageWidth (O.Wand);
   end Get_Width;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (O : in out Object) is
      function NewMagickWand return System.Address;
      pragma Import (C, NewMagickWand, "NewMagickWand");
      -- wand/MagickWand.h:184:4
   begin
      O.Wand := NewMagickWand;
   end Initialize;

      ----------
   -- Read --
   ----------

   procedure Read (O : Object; Filename : String) is
      function MagickReadImage
        (Wand     : System.Address;
         Filename : chars_ptr)
         return MagickBooleanType;
      pragma Import (C, MagickReadImage, "MagickReadImage");
      -- ./wand/magick-image.h:224:3
   begin
      if MagickReadImage (O.Wand, New_String (Filename)) = MagickFalse then
         raise MagickError;
      end if;
   end Read;

   ------------
   -- Resize --
   ------------

   procedure Resize (O : Object;
                     Width  : Size;
                     Height : Size;
                     Filter : FilterTypes;
                     Blur   : Long_Float := 1.0) is
      function MagickResizeImage
        (Wand   : System.Address;
         Width  : Size;
         Height : Size;
         Filter : FilterTypes;
         Blur   : Double) return MagickBooleanType;
      pragma Import (C, MagickResizeImage, "MagickResizeImage");
      -- ./wand/magick-image.h:233:3
   begin
      if MagickResizeImage
        (O.Wand, Width, Height, Filter, double (Blur)) /= MagickTrue then
         raise MagickError with "can not resize image";
      end if;
   end Resize;

   -----------------------------
   -- Set_Compression_Quality --
   -----------------------------

   procedure Set_Compression_Quality (O : Object; Value : Float := 100.0) is
      function MagickSetImageCompressionQuality
        (Wand : System.Address; Quality : Unsigned_Long) return MagickBooleanType;
      pragma Import (C, MagickSetImageCompressionQuality,
                     "MagickSetImageCompressionQuality");
      -- ./wand/magick-image.h:260:3
   begin
      if MagickSetImageCompressionQuality (O.Wand, unsigned_long (Value)) /= MagickTrue then
         raise MagickError with "Can not set compression quality";
      end if;
   end Set_Compression_Quality;

   ------------------
   -- Set_Filename --
   ------------------

   procedure Set_Filename (O : Object; Filename : String) is
      function MagickSetImageFilename
        (Wand     : System.Address;
         Filename : Interfaces.C.Strings.Chars_Ptr)
         return MagickBooleanType;
      -- ./wand/magick-image.h:264:3
      pragma Import (C, MagickSetImageFilename, "MagickSetImageFilename");
   begin
      if MagickSetImageFilename
        (O.Wand, New_String (Filename)) /= MagickTrue then
         raise MagickError with "can not set filename " & Filename;
      end if;
   end Set_Filename;

   -----------
   -- Write --
   -----------

   procedure Write (O : Object; Filename : String) is
      function MagickWriteImage
        (Wand     : System.Address;
         Filename : Interfaces.C.Strings.Chars_Ptr) return MagickBooleanType;
      pragma Import (C, MagickWriteImage, "MagickWriteImage");
      -- ./wand/magick-image.h:326:3
   begin
      if MagickWriteImage (O.Wand, New_String (Filename)) /= MagickTrue then
         raise MagickError with "write error";
      end if;
   end Write;

end MagickWand;
