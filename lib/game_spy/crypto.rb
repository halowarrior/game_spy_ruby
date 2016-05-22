require 'openssl'
require 'securerandom'

class GameSpy::Crypto
  extend FFI::Library
  ffi_lib FFI::Compiler::Loader.find("game_spy")

  XXTEA_KEY_SIZE = 17

  attach_function "gsXxteaDecrypt", [ :pointer, :int, :pointer, :pointer], :pointer
  attach_function "gsXxteaEncrypt", [ :pointer, :int, :pointer, :pointer], :pointer

  def self.generate_key
    res = 4.times.map{Random.rand(9000)}.pack('l>*')
    res[0] = "\x01"
    res
  end

  def self.encrypt(data, key)
    raise "key wrong size: #{key}(#{key.bytesize})" if key.bytesize != 16
    # puts key.inspect
    n_out = FFI::MemoryPointer.new(:uint32)

    key_ptr = FFI::MemoryPointer.new(:char, key.bytesize + 1)
    key_ptr.put_bytes(0, key + "\x00")

    data_ptr = FFI::MemoryPointer.new(:char, data.bytesize + 1)
    data_ptr.put_bytes(0, data + "\x00")

    tmp = gsXxteaEncrypt(data_ptr, data.length, key_ptr, n_out)
    result = tmp.read_bytes(n_out.read_uint)
    result
  end

  def self.decrypt(data, key)
    # raise "Error: Key size is wrong" unless key.length == XXTEA_KEY_SIZE
    n_out = FFI::MemoryPointer.new(:int)

    key_ptr = FFI::MemoryPointer.new(:char, key.bytesize + 1)
    key_ptr.put_bytes(0, key + "\x00")


    data_ptr = FFI::MemoryPointer.new(:char, data.bytesize + 1)
    # data_ptr.write_string(data)
    data_ptr.put_bytes(0, data + "\x00")


    tmp = gsXxteaDecrypt(data_ptr, data.bytesize-4, key, n_out)
    tmp.read_bytes(n_out.read_uint-4)
  end

  def self.caluculate_real_len(str)
    len = str.bytesize
    if (len % 4 == 0)     #// Fix for null terminated strings divisible by 4
      real_len = (len/4)+1
    else
      real_len = (len + 3)/4
    end
    real_len + 1
  end
end
