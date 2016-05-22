class GameSpy::Challenge
  extend FFI::Library
  ffi_lib FFI::Compiler::Loader.find("game_spy")

  GTI2_CHALLENGE_LEN = 32
  GTI2_RESPONSE_LEN  = 32

  attach_function "gti2GetChallenge", [:pointer], :pointer
  attach_function "gti2VerifyChallenge", [:pointer], :int
  attach_function "gti2GetResponse", [:pointer, :pointer], :pointer
  attach_function "gti2CheckResponse", [:pointer, :pointer], :bool
  def self.generate
    buffer = FFI::MemoryPointer.new(:char, GTI2_CHALLENGE_LEN + 1)
    gti2GetChallenge(buffer)
    buffer.read_bytes(GTI2_CHALLENGE_LEN)
  end

  def self.get_response(challenge)
    buffer = FFI::MemoryPointer.new(:char, GTI2_RESPONSE_LEN + 1)
    output = gti2GetResponse(buffer, challenge)
    output.read_bytes(GTI2_RESPONSE_LEN)
  end

  def self.check_response( response1, response2 )
    gti2CheckResponse(response1, response2)
  end

  def self.verify( challenge )
    gti2VerifyChallenge(challenge).to_bool
  end
end
