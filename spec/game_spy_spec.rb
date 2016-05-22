require "spec_helper"

describe GameSpy do
  describe "wide character support" do
    describe "utf8_to_ucs2_string" do
      it "converts to unicode string" do
        expect(GameSpy::String.utf8_to_ucs2("ABC")).to eql("A\x00B\x00C\x00")
      end
    end
  end

  describe "crypto" do

    describe "generate_key" do
      it "returns the right sized key" do
        expect(GameSpy::Crypto.generate_key.length).to eql(GameSpy::Crypto::XXTEA_KEY_SIZE - 1)
      end
      it "returns the correct lenght" do
        10000.times.each do |i|
          expect(GameSpy::Crypto.generate_key.length).to eql(GameSpy::Crypto::XXTEA_KEY_SIZE - 1)
        end
      end
    end

    describe "encrypt" do
      it "encrypts correctly" do

        10000.times do |i|
          data = "ZZZZZZZZ"
          key = 16.times.map{'a'}.join
          encrypt_result = GameSpy::Crypto.encrypt(data, key)
          expect(encrypt_result[0..data.length-1]).to eql("\x6E\xDF\xF2\x21\x56\xE8\xC1\xB6".force_encoding("ASCII-8BIT"))
        end
      end

      it "decryptes a problem key" do
        100000.times.each_with_index do |i|
          key = GameSpy::Crypto.generate_key
          data = "ABCDABCDABCDAAAAAAAAAAAAAAAFSDFSDFSFDSFDSFDSDFFS"
          encrypt_result = GameSpy::Crypto.encrypt(data, key)
          decrypt_result = GameSpy::Crypto.decrypt(encrypt_result, key)
          expect(decrypt_result).to eql(data)
        end
      end

      it "decrypts some bytes" do
        100000.times.each_with_index do |i|
          key = GameSpy::Crypto.generate_key
          data = "ABCDABCDABCDAAAAAAAAAAAAAAAFSDFSDFSFDSFDSFDSDFFS"
          encrypt_result = GameSpy::Crypto.encrypt(data, key)
          decrypt_result = GameSpy::Crypto.decrypt(encrypt_result, key)
          expect(decrypt_result).to eql(data)
        end
      end
    end
  end

  describe "challenge" do

    describe "check_response" do

      it "is valid" do

        500.times.each do |i|
          client_chal = GameSpy::Challenge.generate
          server_chal =  GameSpy::Challenge.get_response(client_chal)
          server_response = GameSpy::Challenge.get_response(client_chal)

          expect(GameSpy::Challenge.check_response(server_response, server_chal)).to be true
        end
      end
    end
    describe "generate" do

      it "generates two unique challenges" do
        ch1 = GameSpy::Challenge.generate
        sleep(0.01)
        ch2 = GameSpy::Challenge.generate
        expect(ch1).to_not eql(ch2)
      end

      it "has a different number each time" do
        last = nil
        500.times.each do |i|
          tmp = GameSpy::Challenge.generate

          if last != nil
            expect(tmp).to_not eql(last)
          end
          last = tmp
          sleep(0.01)
        end
      end
      it "has correct length" do
        expect(GameSpy::Challenge.generate.length).to eql(GameSpy::Challenge::GTI2_CHALLENGE_LEN)
      end

      it "is valid" do
        challenge = GameSpy::Challenge.generate
        expect(GameSpy::Challenge.verify(challenge)).to be true
      end
    end
    describe "verify_challenge" do
      it "returns false" do
        expect(GameSpy::Challenge.verify("ABC")).to be false
      end

      it "returns true" do
        challenge = GameSpy::Challenge.generate
        expect(GameSpy::Challenge.verify(challenge)).to be true
      end
    end
  end
end
