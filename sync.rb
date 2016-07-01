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

def sync(ldir, remote, rdir, opts)
  opt = opts.join(' ')
  put = "#{RSYNC} #{opt} #{trailing_slash(ldir)} #{remote}:#{rdir}"
  get = "#{RSYNC} #{opt} #{remote}:#{trailing_slash(rdir)} #{ldir}"
#  puts put
  system(put)
#  puts get
  system(get)
end

def guess_path()
  path = Dir.pwd.sub(/^#{ENV['HOME']}\//,'')
  puts path
  path
end

def guess_remote()
  case `hostname`
  when /imac2.local/
    'tmac2.melt.kyutech.ac.jp'
  when /tmac2.local/
    'imac2.melt.kyutech.ac.jp'
  else
    "sandbox.local"
  end
end

#
# main starts here
#

args = []
opts = []

while (arg=ARGV.shift)
  case arg
  when /\A-p/
    port = ARGV.shift
    opts.push("-e 'ssh -p #{port}'")
  when /\A--port=(\d+)/
    port = $1
    opts.push("-e 'ssh -p #{port}'")
  when /\A--/
    opts.push(arg)
  when /\A-/
    opts.push(arg)
    arg = ARGV.shift
    opts.push(arg)
  else
    args.push(arg)
  end
end

case args.length
when 0
  sync(".", guess_remote(), guess_path(), opts)

when 1
  remote, there = args[0].split(/:/)
  if there.nil?
    there = guess_path()
  end
  sync(".", remote, there, opts)

when 2
  remote,there = args[1].split(/:/)
  sync(args[0], remote, there, opts)

else
  usage()
end
