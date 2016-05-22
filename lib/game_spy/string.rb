class GameSpy::String
  extend FFI::Library
  ffi_lib FFI::Compiler::Loader.find("game_spy")

  attach_function "UTF8ToUCS2String", [:pointer, :pointer ], :void

  def self.utf8_to_ucs2(str)
    ucs2_len = str.length * 2
    ucs2_str = FFI::MemoryPointer.new(:int, ucs2_len)
    UTF8ToUCS2String(str, ucs2_str)
    ucs2_str.read_bytes(ucs2_len)
  end

#   // Convert a UCS2 (Unicode) string to it's UTF8 equivalent
# //
# //  [in]  theUCS2String, double NULL terminated UTF8String
# //  [out] theUTF8String, NULL terminated c-string
# //
# //  returns the length of theUTF8String
# //
# //    Remarks:
# //    Memory allocated for theUTF8String may need to be up to 1.5* the size of theUCS2String
# //      This means that for each UCS2 character, 3 UTF8 characters may be generated
# int UCS2ToUTF8String(const UCS2String theUCS2String, UTF8String theUTF8String)

end