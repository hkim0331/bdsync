#!/usr/bin/env ruby
# coding: utf-8

EXCLUDES = "--exclude='*~' --exclude='*.bak' --exclude='.DS_Store'"
#RSYNC = "rsync -au --dry-run"
RSYNC = "rsync -auv #{EXCLUDES}"

def usage
  print <<EOU
usage:
	sync here remote:there
	sync remote:there
	sync
EOU
  exit(1)
end

#FIXME: s=="" のときダメ。
def trailing_slash(s)
  if s[-1]=="/"
    s
  else
    s+"/"
  end
end

def sync(ldir, remote, rdir, port)
  ssh = "-e 'ssh -p #{port}'"
  put = "#{RSYNC} #{ssh} #{trailing_slash(ldir)} #{remote}:#{rdir}"
  get = "#{RSYNC} #{ssh} #{remote}:#{trailing_slash(rdir)} #{ldir}"
  puts put
  system(put)
  puts get
  system(get)
end

#FIXME: differ HOME between OSX and Linux
def rpath(path, base = ENV['HOME'])
  if path =~ /^#{base}\//
    path.sub(/^#{base}\//,'')
  else
    path
  end
end

def guess_path()
  path = Dir.pwd.sub(/^#{ENV['HOME']}\//,'')
  puts path
  path
end

# just a test
def guess_remote()
  "sandbox.local"
end

#
# main starts here
#
port = 22
args = []

while (arg=ARGV.shift)
  case arg
  when /\A-p/
    port = ARGV.shift
    port = port.to_i
  when /\A--port=(\d+)/
    port = $1.to_i
  else
    args.push(arg)
  end
end

case args.length
when 0
  sync(".", guess_remote(), guess_path(), port)
when 1
  # arg: [remote:there]
  remote, there = args[0].split(/:/)
  if there.nil?
    there = rpath(pwd)
  end
  sync(".", remote, there, port)
when 2
# arg: [here remote:there]
  remote,there = args[1].split(/:/)
  sync(args[0], remote, there, port)
else
  usage()
end
