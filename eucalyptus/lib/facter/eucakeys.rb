# eucakeys.rb
# Grab all eucalyptus key files and export them as facts so we can use them within the Eucalyptus module

require 'facter'

eucakey_dir = '/var/lib/eucalyptus/keys'

# Get all keys in the top level eucakey_dir
if File.directory?(eucakey_dir)
  keyfiles = Dir.entries(eucakey_dir)
  keyfiles.each do |name|
    if name.match(/\.pem/)
      Facter.add("eucakeys_#{name.sub('.pem','').sub('-','_')}") do
        setcode do
          File.read("#{eucakey_dir}/#{name}")
        end
      end
    end
    if name.match(/\.p12/)
      Facter.add("eucakeys_euca_p12") do
        setcode do
          File.read("#{eucakey_dir}/#{name}")
        end
      end
    end
  end
end

if File.directory?(eucakey_dir)
  # Check if entries in eucakey_dir are directories, if they are return them minus the . and .. entries
  dir_contents = Dir.entries(eucakey_dir).select {|entry| File.directory? File.join(eucakey_dir,entry) and !(entry =='.' || entry == '..') }
  # For each cluster directory, grab all pem files and set as facts making sure all fact names use underscores
  dir_contents.each do |clustername|
   keyfiles = Dir.entries(eucakey_dir+"/"+clustername)
   keyfiles.each do |keyname|
     if keyname.match(/\.pem/)
       Facter.add("eucakeys_" + clustername + "_#{keyname.sub('.pem','').sub('-','_')}") do
         setcode do
            File.read("#{eucakey_dir}/#{clustername}/#{keyname}")
         end
       end
     end
     # Collect VPN tunnel passwords for VNET_TUNNELLING
     if keyname.match(/vtunpass/)
       Facter.add("eucakeys_" + clustername + "_#{keyname}") do
         setcode do
            File.read("#{eucakey_dir}/#{clustername}/#{keyname}")
         end
       end
     end
   end
  end
end
