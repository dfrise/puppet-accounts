module Puppet::Parser::Functions
  newfunction(:extract_group_members, :type => :rvalue, :doc => <<-EOS
From Hash of all users and their configuration extracts group membership
EOS
  ) do |args|

    if args.size != 2
      raise(Puppet::ParseError, "extract_group_members(): Wrong number of args, given #{args.size}, accepts just 2")
    end

    if args[0].class != Hash and args[1].class != Hash
      raise(Puppet::ParseError, "extract_group_members(): both must be a Hash, you passed a " + args[0].class.to_s + " and "+ args[1].class.to_s)
    end

    res = args[1].clone
    args[0].each do |user, val|
      if val.key? 'groups'
        val['groups'].each do |g|
          unless res.key?(g)
            res[g] = {'members' => []}
          else
            res[g]['members'] = [] unless res[g].key?('members')
          end
          res[g]['members'] << user
        end
      end
    end
    res
  end
end