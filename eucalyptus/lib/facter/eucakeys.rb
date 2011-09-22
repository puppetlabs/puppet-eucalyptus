require 'facter'
eucakey_dir = '/var/lib/eucalyptus/keys'
if File.directory?(eucakey_dir)
  keyfiles = Dir.entries(eucakey_dir)
  keyfiles.each do |name|
    if name.match(/\.pem/)
      Facter.add("eucakeys_#{name.sub('.pem','')}") do
        setcode do
          File.read("#{eucakey_dir}/#{name}")
        end
      end
    end
  end
end
## this is TEMPORARY!
# the clustername is a sub dir that should be dynamic. keys for a cc and nc need
# to be fetched from the appropriate cluster dir
# for now, we're hard-coding a cluster name
if File.directory?(eucakey_dir+'/cluster00')
  keyfiles = Dir.entries(eucakey_dir+'/cluster00')
  keyfiles.each do |name|
    if name.match(/\.pem/)
      Facter.add("eucakeys_cluster00_#{name.sub('.pem','')}") do
        setcode do
          File.read("#{eucakey_dir}/cluster00/#{name}")
        end
      end
    end
  end
end
