function cd -d 'Change directory and list contents'
  builtin cd $argv

  if test $status = 0
    ls
  end
end
