# require "spec_helper"

# describe WarriorUtils do
#   describe "sread_bits" do
#     let(:output) { FFI::MemoryPointer.new(:int, 20) }
#     it "reads 1 bit integer correctly (value: 1)" do
#       test_string = "s"
#       ptr = FFI::MemoryPointer.from_string(test_string)
#       bit_to_int = WarriorUtils.sread_bits(ptr, output, 1)
#       expect(bit_to_int).to eql(BinData::Bit1le.read(test_string).to_i)
#     end
#     it "reads 1 bit integer correctly (value: 0)" do
#       test_string = "z"
#       ptr = FFI::MemoryPointer.from_string(test_string)
#       bit_to_int = WarriorUtils.sread_bits(ptr, output, 1)
#       expect(bit_to_int).to eql(BinData::Bit1le.read(test_string).to_i)
#     end
#   end

#   describe "crc32" do

#     it "returns the same value A" do
#       str = "A"
#       ruby_val = Zlib.crc32(str)
#       c_val = WarriorUtils.crc32(str)
#       expect(c_val).to eql(ruby_val)
#     end

#     it "returns the same value" do
#       str = "B"
#       ruby_val = Zlib.crc32(str)
#       c_val = WarriorUtils.crc32(str)
#       expect(c_val).to eql(ruby_val)
#     end
#   end

#   describe "wide character support" do
#     describe "utf8_to_ucs2_string" do
#       it "converts to unicode string" do
#         expect(WarriorUtils.utf8_to_ucs2_string("ABC")).to eql("A\x00B\x00C\x00")
#       end
#     end

#     describe "write_bstr" do
#       # it "properly encodes ASCII characters" do
#       #   bstr = WarriorUtils.convert_to_bstr("ABC")
#       #   expect(bstr).to eql("ABC")
#       # end
#       # it "properly encodes non-ASCII characters" do
#       #   bstr = WarriorUtils.convert_to_bstr("ABC‡°")
#       #   expect(bstr).to eql("ABC")
#       # end
#     end
#   end

#   # describe "tea_encrypt" do
#   #   it "has the same output" do
#   #     data = "SOME DATA"
#   #     key = "random_password"
#   #     ruby_encrypt = Crypt::TEA.encrypt(data, key)
#   #     c_lib_encrypt = WarriorUtils.tea_encrypt(data, key)
#   #     puts "length: #{c_lib_encrypt.length}"
#   #     debugger
#   #     expect(ruby_encrypt).to eql(c_lib_encrypt)
#   #   end
#   # end

#   # describe "QuartToTrip" do
#   #   it "returns a value" do
#   #     expect(WarriorUtils.quart_to_trip("atomical")).to eql("a t o m")
#   #   end
#   # end

#   describe "ffi tests" do

#     describe "test_method_1" do
#       it "returns a 32 bit uint" do
#         expect(WarriorUtils.test_method_1()).to eql(3554254475)
#       end
#     end
#     describe "char_array_return" do
#       it "returns a string of chars" do
#         expect(WarriorUtils.char_array_return).to eql("ABCDEFG")
#       end
#     end
#   end


#   describe "game_spy_encrypt" do
#     it "encrypts correctly" do
#       data = "ZZZZZZZZ"
#       key = 16.times.map{'a'}.join
#       encrypt_result = WarriorUtils.game_spy_encrypt(data, key)
#       expect(encrypt_result[0..data.length-1]).to eql("\x6E\xDF\xF2\x21\x56\xE8\xC1\xB6".force_encoding("ASCII-8BIT"))
#     end


#     it "returns encrypts and decrypts correctly" do
#       # problem is that length is 8, should be 12
#       (1..20).each do |i|
#         data = i.times.map{i}.join
#         len = data.length
#         key = 16.times.map{'a'}.join
#         encrypt_result = WarriorUtils.game_spy_encrypt(data, key)
#         decrypt_result = WarriorUtils.game_spy_decrypt(encrypt_result, key, len)
#         expect(decrypt_result).to eql(data)
#       end
#     end
#   end
# end
