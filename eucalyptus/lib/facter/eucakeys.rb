require 'facter'
eucakey_dir = '/var/lib/eucalyptus/keys'
keyfiles = Dir.entries(eucakey_dir)
keyfiles.each do |name|
  if name.match(/\.pem/)
    Facter.add("eucakeys_#{name}") do
      setcode do
        File.read("#{eucakey_dir}/#{name}")
      end
    end
  end
end
