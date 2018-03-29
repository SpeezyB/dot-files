# wrapper for dev up to make it run nice an smooth :)
#
=begin
[ ] pipe all output to 2>&1 and pump that out to a /tmp/ log file
  [ ] add logging
  [ ] optionally save the log file, rather than just temporarly 
  [ ] output anything to console that is erroring out.
=end
BEGIN{
  $opts               = {
    help:             false,
    full_report:      false,
    showopts:         false,
    pry:              false,
    yarnfix:          false,
    edit:             false,
    reset_railgun:    false,
    stay_up:          false,
    rebase:           false,
    update_brew:      false,
    update_dev:       false,
    update_test:      false,
    skip_dev_update:  false,       # <- 'dev update' is implemented differently than most other dev options, so i stil need to figure it out :(
                                   # ^ I've put the dev update in the calling script (wrapper) so at least it gets done.
    dev_down:         false,
    dev_up:           false,
    post_pause:       false,
    add_repo:         false,
    skip_repo:        false,
    output:           true
  }

  $tasks              = {
    ruby_check:       false,
    help:             false,
    showopts:         false,
    pry:              false,
    yarnfix:          false,
    reset_railgun:    false,
    reset_db:         false,
    stay_up:          false,
    rebase:           false,
    update_brew:      false,
    update_dev:       false,
  }
  
  devconfig = "/Users/#{ENV['USER']}/.devconfig"
  if File.exist?(devconfig)
    File.open(devconfig, 'r'){|devfile|
      devfile.each_line{|lin|
        if lin.include?("srcpath.default = ") || lin.include?("default = ")
          GH_dir = File.expand_path(lin.split(" ").last)
        end
      }
    }
  else
    raise "File #{devconfig} Doesn't EXIST!!"
    GH_dir = "/Users/" + ENV["USER"] + "/src/github.com/Shopify"
  end

  Ruby_ver            = '2.4.1'  
  def ck_ruby
    %x(ruby -v).include?(Ruby_ver)
  end

  OG_dir              = %x(pwd)
  if ck_ruby
    puts "Ruby version test passed."
    $tasks[:ruby_check] = !$tasks[:ruby_check]
  else
    Dir.chdir(Dir.home)
    if !ck_ruby
      raise 'Invalid Ruby version!!'
    end
  end

  if %w(true on).include?($opts[:output].to_s)
    Output = ''
  else 
    Output = '2>&1 > /dev/null'
  end

  require 'pry'
  require 'io/console'
  require 'paint'
  Paint.mode[256]
  Dev                 = '/opt/dev/bin/dev'
  Padding             = 55
  Pad_char            = %w(> <)
  Done                = " " * (Padding) + " #{'-'*5}DONE#{'-'*5}"
#  Repos               = %w(shopify sauron country_db)          # <- Replaced w/ logic to temporarly add a repo via cmd line
  Troubleshoot_list   = %w(yarnfix reset_db reset_railgun rebase help pry)
  Bools               = %w(true false)
  
  if !(ARGV.empty?)
    ARGV.each{|a| a.start_with?('-') ? $opts[a[1..-1].to_sym] = !($opts[a[1..-1].to_sym]) : $opts[ARGV[ARGV.index(a) - 1][1..-1].to_sym] = a.downcase }
  end

  if $opts[:edit]
    exec_str = ENV["EDITOR"] + " /Users/benspiessens/.config/fish/functions/#{File.basename(__FILE__)}"
    exec(exec_str)
  end

  if ($opts[:add_repo] == true || $opts[:add_repo] == false)
    Repos             = %w(shopify sauron)
  else
    Repos             = %w(shopify sauron #{$opts[:add_repo]})
  end

  Repos.each do |r|
    $tasks.update({
      "#{r}_checkout_master".to_sym =>  false,
      "#{r}_git_fetch".to_sym       =>  false,
      "#{r}_git_pull".to_sym        =>  false,
      "#{r}_dev_up".to_sym          =>  false,
      "#{r}_dev_down".to_sym        =>  false
    })
  end
}       # <- End of Startup

def sub(n1, n2)
  n1 < n2 ? n2 - n1 : n1 - n2
end

def showopts
  output = " " * 25 +  Paint[" Options \n" + " " * 25 + "=" * 9 + "\n", :bright]
  $opts.each do |k,v|
    if v
      output << " " * 15 + "-" + Paint[k.to_s, :bright] + " " * (20-k.to_s.size) + "=>  " + Paint[v.to_s, :green] + "\n"
    else
      output << " " * 15 + "-" + Paint[k.to_s, :bright] + " " * (20-k.to_s.size) + "=>  " + Paint[v.to_s, :red]   + "\n"
    end
  end
  output << "\n\n"
  $tasks[:showopts] = true
  puts output
end

def disp(line)
  line.chomp!
  if Pad_char[1].nil?
    puts Pad_char[0] * Padding + " #{Paint[line, :blue, :bright]} " + " " * ((Padding * 2) - line.size ) + Pad_char[0] * Padding + "\n"
  else
    puts Pad_char[0] * Padding + " #{Paint[line, :blue, :bright]} " + " " * ((Padding * 2) - line.size ) + Pad_char[1] * Padding + "\n"
  end
  true
end

def yarnfix
  if system("ssh-add -k")
    disp 'ssh-add -k has been completed.'
    $tasks[:yarnfix] = true
    return true
  else
    raise "Error running the yarnfix"
  end
end

def rebase_on_master(repo)
  disp "Rebasing on master branch of #{repo} Repo"
  if %x(git pull --rebase origin master #{Output})
    disp "Rebase Complete."
    $tasks[:rebase] = true
    return true
  else
    raise "Error running Git pull --rebase origin master "
  end
end
  
def reset_railgun(repo)
  Dir.chdir(GH_dir + '/' + repo)
  if %x(#{Dev} reset-railgun #{Output})
    disp "reset_railgun on #{repo} repo completed."
    $tasks[:reset_railgun] = true
    return true
  else
    raise "Error Cannot Reset railgun"
  end
end

def reset_db(repo)
  Dir.chdir(GG_dir + '/' + repo)
  if %x(#{Dev} reset-db #{Output})
    disp "reset_db on #{repo} repo completed."
    $tasks[:reset_db] = true
    return true
  else 
    raise "Error Cannot Reset_db on #{repo}"
  end
end

def update_brew
  result = false
  binding.pry if $opts[:pry] == 'update_brew'
  disp "Updating / Upgrading Brew Packages ..."
  if system("brew update #{Output}")
    disp "Brew update complete."
    if system("brew upgrade #{Output}")
      disp "Brew upgrade complete."
      result = true
      $tasks[:update_brew] = true
    else
      raise "Error running brew upgrade."
    end
  else
    raise "Error running brew update."
  end
  return result 
end

def update_dev2
  if system("source _update_dev.fish")
    return true
  else
    raise "Error running Dev_update2"
  end
end

def update_dev
  binding.pry if $opts[:pry] == 'update_dev'
  case
  when $opts[:skip_dev_update] == true || !Bools.include?($opts[:skip_dev_update])
    disp "Dev Update was skipped"
    $tasks[:update_dev] = $opts[:skip_dev_update]
    return true
  when !Bools.include?($opts[:update_dev])
    disp "Dev Update was already done from the calling script."
    $tasks[:update_dev] = $opts[:update_dev]
    return true
  when $opts[:update_test] == true
    disp "Dev update in Test mode"
    $tasks[:update_dev] = 'test'
    return true
  end # End of case
  
  disp "Updating Dev ..."
  Dir.chdir('/opt/dev/bin')
  disp "Current Dir: #{Dir.pwd}"
#  dev_cmd = "#{Dev} update"
#  disp "Dev_cmd: #{dev_cmd}"
#  isdone = system("source /opt/dev/bin/dev update")
#  isdone = system("eval (source /opt/dev/dev.fish; dev update)")
#  isdone = system("command /opt/dev/dev.fish update)")
  isdone = system("command dev update")
#  %x[source #{dev_cmd}]
#  isdone = system("fish -c \"source /opt/dev/dev.fish update\"")  
=begin
  if system("#{Dev} update")
    disp Done
  else
    raise "Error running Dev update"
  end
=end
  puts "the result is: #{isdone}"
  isdone ? $tasks[:update_dev] = true : nil
  return isdone
end

def help
  # Display help stuff
  puts %Q(

    #{showopts if $opts[:showopts] || $opts[:help]}

           Usage: #{$0} 
                  #{$0} -option DATA
         Example: #{$0} -pry dev_repos
                  #{$0} -dev_up shopify 
                  #{$0} -reset_railgun shopify
                  #{$0} -reset_db sauron


)
  $tasks[:help] = !$tasks[:help]
  exit 0
end

def dev_down(repo)
  binding.pry if $opts[:pry] == 'dev_down'
  if $opts[:stay_up] 
    $tasks[:stay_up] = true
    return nil
  else
    Dir.chdir(GH_dir + '/' + repo)
    disp "Running Dev Down on the #{repo} Repo"
    if %x(#{Dev} down #{Output})
      disp Done
      $tasks["#{repo}_dev_down".to_sym] = true
    else
      raise "Error runing Dev Down on the #{repo} Repo"
    end
  end
end

def devup_repos(repo)
  binding.pry if $opts[:pry] == 'dev_repos'
  return if repo.include?($opts[:skip_repo].to_s)

  Dir.chdir(GH_dir + '/' + repo)
  
  disp "Checking branch"
   if %x(git branch).include?('* master')
     disp "Already on Master. " 
     disp Done
     $tasks["#{repo}_checkout_master".to_sym] = true
   else
     disp "Changing back to master branch"
     if system('git checkout master') && %x(git branch).include?('* master')
       disp Done
       $tasks["#{repo}_checkout_master".to_sym] = true
     else
       raise "Error changing branch back to master on #{repo} Repo"
     end
   end

  disp "Running git fetch on #{repo}"
  if system("git fetch #{Output}")
    disp Done
    $tasks["#{repo}_git_fetch".to_sym] = true
  else
    raise "Error running Git Fetch on #{repo}"
  end

 disp "Running git pull origin master on #{repo}"
  if system("git pull origin master #{Output}")
    disp Done
    $tasks["#{repo}_git_pull".to_sym] = true
  else
    raise "Error running Git pull origin master on #{repo}"
  end

  disp "Running Dev up on #{repo}"
  if system("#{Dev} up #{Output}")
    disp Done
    $tasks["#{repo}_dev_up".to_sym] = true
  else
    raise "Error running Dev up on #{repo}"
  end

  dev_down(repo) if !$opts[:stay_up]
end

def pause
  STDIN.getch
  disp "Pause Complete. Goodbye."
end

def task_list(show_troubles=false)
  pad = 0
  $tasks.each_value{|v|
    v.to_s.size > pad ? pad = v.to_s.size : next
  }
   title = ' Completed Task List '
  show_troubles ? title << ' -DEBUG MODE- ' : nil
  puts "\n#{Paint[title, :white, :bright]}\n" + Paint["=" * title.size, :white, :bright]

#  binding.pry #if $opts[:pry] == 'task_list'
  if $opts[:skip_repo] != false
    skipped_task_list = $tasks.select{|k,v| k.to_s.include?($opts[:skip_repo])}.keys    
    skipped_task_list.each do |task|
      $tasks.update(task => 'skipped' )
    end
  end

  $tasks.each do |k, v|
    if Troubleshoot_list.include?(k.to_s)
      if show_troubles || v
        if v
          puts "[ " + Paint[v.to_s, :green] + " " * sub(pad,v.to_s.size) + " ] = #{Paint[k.to_s, :white, :bright]}"
        else
          puts "[ " + Paint[v.to_s, :red]   + " " * sub(pad,v.to_s.size) + " ] = #{Paint[k.to_s, :white, :bright]}"
        end
      else 
        next
      end
    else
      if v
        if v != true 
          puts "[ " + Paint[v.to_s, :yellow, :bright]  + " " * sub(pad,v.to_s.size) + " ] = #{Paint[k.to_s, :white, :bright]}"
        else
          puts "[ " + Paint[v.to_s, :green] + " " * sub(pad,v.to_s.size) + " ] = #{Paint[k.to_s, :white, :bright]}"
        end
      else
        puts "[ " + Paint[v.to_s, :red]   + " " * sub(pad,v.to_s.size) + " ] = #{Paint[k.to_s, :white, :bright]}"
      end
    end
  end
  puts "\n"
end

begin           # Begin Main.
  binding.pry if $opts[:pry]
  showopts if $opts[:showopts] && !$opts[:help]

  case
  when $opts[:test] || $opts[:pause]
    pause
  when $opts[:help]
    help
  when $opts[:yarnfix]
    disp Done if yarnfix
  when $opts[:reset_railgun]
    if Repos.include?($opts[:reset_railgun])
      disp Done if reset_railgun $opts[:reset_railgun] 
    else
      raise ArgumentError "You need to provide a Repo to reset_railgun on!"
    end
  when $opts[:reset_db]
    if Repos.include?($opts[:reset_db])
      disp Done if reset_db $opts[:reset_db]
    else
      raise ArgumentError "You need to provide a Repo to reset_db on!"
    end
  when $opts[:rebase]
    disp Done if rebase_on_master
  when $opts[:update_brew]
    disp Done if update_brew
  when $opts[:update_dev]
    disp Done if update_dev
  when $opts[:update_dev2]
    disp Done if update_dev2
  when $opts[:dev_down]
    if Repos.include?($opts[:dev_down])
      disp Done if dev_down($opts[:dev_down])
    else
      Repos.each do |r|
        disp "Dev Downing #{r} repo"
        disp Done if dev_down(r)
      end
    end
  when $opts[:dev_up]
    if Repos.include?($opts[:dev_up])
      disp "Moving to #{$opts[:dev_up]} Repo..."
      disp Done if devup_repos($opts[:dev_up])
    else
      Repos.each do |r|
        if r.include?($opts[:skip_repo].to_s)
          next
        end
        disp "Moving to #{r} repo ..."
        disp Done if devup_repos(r)
      end
    end
  else      # <- else of the main case statement
    disp Done if update_brew    
    disp Done if update_dev

    Repos.each do |r|
      if r.include?($opts[:skip_repo].to_s)
        next
      end
      disp "Moving to #{r} repo"
      disp Done if devup_repos(r)
    end
  end       # <- end of the main case statement

rescue => err
  puts "An Error has occured.\n\t#{err.message}\n\t#{err.backtrace.inspect}"
  task_list true
  exit 1
end

END {
  $opts[:full_report] ? task_list(true) : task_list
  %x(cd #{OG_dir})
  pause if $opts[:post_pause]
}
