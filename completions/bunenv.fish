function __fish_bunenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'bunenv' ]
    return 0
  end
  return 1
end

function __fish_bunenv_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c bunenv -n '__fish_bunenv_needs_command' -a '(bunenv commands)'
for cmd in (bunenv commands)
  complete -f -c bunenv -n "__fish_bunenv_using_command $cmd" -a \
    "(bunenv completions (commandline -opc)[2..-1])"
end
