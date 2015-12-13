require_relative '../caesars_cipher'

describe CaesarsCipher do

  before :each do
    @cipher = CaesarsCipher.new
  end

  describe 'supported_characters' do
    it 'contains letters a-z' do
      expect(@cipher.supported_characters).to include('a')
      expect(@cipher.supported_characters).to include('h')
      expect(@cipher.supported_characters).to include('m')
      expect(@cipher.supported_characters).to include('z')
    end
  end

  describe 'cipher' do
    it 'returns a Hash' do
      expect(@cipher.cipher(4)).to be_a(Hash)
    end

    it 'gives key value pairs containing single letters' do
      expect(@cipher.cipher(4)['a']).to eql 'e'
    end
  end

  describe 'encrypt' do
    it 'returns an encrypted string' do
      expect(@cipher.encrypt(5, "string")).to eql "xywnsl"
    end

    it 'returns an encrypted string with spaces and punctuation' do
      expect(@cipher.encrypt(5, "what a string!")).to eql "bmfy f xywnsl!"
    end

    it 'returns an encrypted string with correct format concerning upper/lower case letters' do
      expect(@cipher.encrypt(5, "What a String!")).to eql "Bmfy f Xywnsl!"
    end

    context 'rotate == 0' do
      it 'returns the given string' do
        expect(@cipher.encrypt(0, "What a string!")).to eql "What a string!"
      end
    end
  end

  describe 'decrypt' do
    it 'returns the decrypted string' do
      expect(@cipher.decrypt(5, "Bmfy f xywnsl!")).to eql "What a string!"
    end
  end
end
