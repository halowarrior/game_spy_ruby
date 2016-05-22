class GameSpy::CDKey
  extend FFI::Library
  ffi_lib FFI::Compiler::Loader.find("game_spy")

  RESPONSE_SIZE = 73

  attach_function "gcd_compute_response", [:pointer, :pointer, :pointer, :int], :void

  # method
  # 0 auth response   = MD5(cdkey + random mod 0xffff + challenge) */
  # 1 reauth response = MD5(challenge + random mode 0xffff + cdkey) */
  def compute_response(key, challenge, method = 0)
    response = FFI::MemoryPointer(:char, RESPONSE_SIZE)
    gcd_compute_response(key, challenge, response, method)
    response.read_bytes(RESPONSE_SIZE)
  end
end


# void gcd_compute_response(char *cdkey, char *challenge,/*out*/ char response[73], CDResponseMethod method);
