function pi
  switch $argv
    case me
      command pint -c 3 bspiessens.dynu.com
    case me 
    case'*'
      command ping -c 3 8.8.8.8 
  end
end

