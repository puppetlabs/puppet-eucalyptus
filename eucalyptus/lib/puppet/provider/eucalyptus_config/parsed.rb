require 'puppet/provider/parsedfile'

eucaconf = "/etc/eucalyptus/eucalyptus.conf"

Puppet::Type.type(:eucalyptus_config).provide(
  :parsed,
  :parent => Puppet::Provider::ParsedFile,
  :default_target => eucaconf,
  :filetype => :flat
) do

  confine :exists => eucaconf
  text_line :comment, :match => /^#/;
  text_line :blank, :match => /^\s*$/;

  record_line :parsed,
    :fields => %w{line}, 
    :match => /(.*)/ ,
    :post_parse => proc { |hash|
      Puppet.debug("eucalyptus config line:#{hash[:line]} has been parsed") 
      if hash[:line] =~ /^\s*(\S+)\s*=\s*(\S+)\s*$/
        hash[:name]=$1
        hash[:value]=$2
      elsif hash[:line] =~ /^\s*(\S+)\s*$/
        hash[:name]=$1
        hash[:value]=false
      else
        raise Puppet::Error, "Invalid line: #{hash[:line]}"
      end
    }

  def self.to_line(hash)
    return super unless hash[:record_type] == :parsed
    "#{hash[:name]}=#{hash[:value]}"
  end

end
