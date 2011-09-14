require 'puppet/provider/parsedfile'

eucaconf = "/etc/eucalyptus/eucalyptus.conf"

Puppet::Type.type(:eucalyptus_config).provide(
  :parsed,
  :parent => Puppet::Provider::ParsedFile,
  :default_target => eucaconf,
  :filetype => :flat
) do

  #confine :exists => eucaconf
  text_line :comment, :match => /^#/;
  text_line :blank, :match => /^\s*$/;

  record_line :parsed,
    :fields => %w{name value comment}, 
    :optional => %w{value comment},
    :match => /^\s*(.*?)(?:\s*=\"\s*(.*?))?\"(?:\s*#\s*(.*))?\s*$/,
    :to_line => proc { |hash|
      str = "#{hash[:name]}=\""
      str += hash[:value] if hash[:value] != :absent
      str += "\""
      str += " # #{hash[:comment]}" unless hash[:comment].nil?
      str
    }

end
