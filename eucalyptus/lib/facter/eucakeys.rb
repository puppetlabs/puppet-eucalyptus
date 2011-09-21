require 'facter'
eucakey_dir = '/var/lib/eucalyptus/keys'
if File.directory?(eucakey_dir)
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
end
