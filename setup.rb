# This is a setup script to install everything in the proper place on a new install
# TODO
# [ ] check what distro and generate a list of required packages to the yaml file
#   [ ] either clone or use the package manager to get those 
#   [ ] start w/ a bash or fish script to make sure that ruby is actually installed first
#       and install it if it isn't.

BEGIN{
  require 'yaml'

  User          = ENV['USER']
  User_home_dir = "/home/#{User}"
  Vim_dir       = "#{User_home_dir}/.vim"
  Git_dir       = "#{User_home_dir}/gh"
  And_cmd       = if ENV['SHELL'].include?('fish')
                    '; and '
                  else
                    ' && '
                  end

  Pathogen_cmd  = "mkdir -p #{Vim_dir}/autoload #{Vim_dir}/bundle" + 
                  And_cmd + "curl -LSso #{Vim_dir}/autoload/pathogen.vim " +
                  "https://tpo.pe/pathogen.vim "

  Data_filename = 'data.yml'

  $data          ={
                    vim_plugins:    [],
                    git_repos:      {}, # name: '', url: '',
                    blacklisted:    ['ipup', 'Question_Of_The_Day', 'dot-files', 'golang', '99bottles'], # These are the ones i'm working on
  }

  $opts         ={
                    showopts:           false,
                    import_from_file:   false,
                    export_to_file:     false,
  }

  if !(ARGV.empty?)
    keys = []
    ARGV.each_with_index do |arg, idx|
      if arg.lstrip.start_with?('-')
        keys << key = arg.chars.drop(1).join.to_sym
        if $opts.has_key?(key)
          $opts[key]  = !$opts[key]  # create the key and flip the bool
        else
          STDERR.puts "Error! -#{key} is not a valid argument!"
          STDERR.puts "For a list of options you can use, run #{$0} -help"
          exit!(2)
        end
      elsif !keys.last.nil?
        key         = keys.last
        data        = if ARGV[idx - 1].start_with?('-')
                        arg.downcase
                      else
                        $opts[keys.last] + arg.downcase.prepend(' ')
                      end # data assignment
        $opts[key]  = data
      else
        raise "Arguments must start with a '-' and then the data!!"
      end # arg.start_with?
    end # ARGV.each
  end # if !ARGV.empty?

} #end of BEGIN

def install_vim_plugin(repo)
  Dir.chdir(File.join(Vim_dir, 'bundle'))
  %x(git clone #{repo})
end

def install_each_git_repo(repo={base_gh_dir: '', repo_url: '', name: ''})
  base_gh_dir = repo[:base_gh_dir]
  repo_url    = repo[:repo_url]
  repo_name   = repo[:name]

  Dir.chdir(base_gh_dir)
  %x(git clone #{repo_url})
  
  Dir.mkdir(repo_name)
  Dir.chdir(repo_name)
  system("./configure#{and_cmd}make#{and_cmd}sudo make install") # <--- This may need to be tweaked depending on repo / tool
end

def grep_vim_gits(dir=Vim_dir)
  plugins = []
  Dir.chdir(File.join(Vim_dir, 'bundle'))
  Dir.each_child do |plugin_dir|
    if File.directory?(plugin_dir)
      Dir.chdir('.git')
      File.open('config', 'r') do |conf_file|
        conf_file.each_line do |lin|
          if lin.include?('url = ')
            plugins.push(lin.split(' ').last)
          end
        end # each conf file line
      end # File.open gh config file / close the file
    end # is plugin_dir a directory?
  end

  return plugins
end

def create_data_file # initial write out and update file
  gh_repos = {}
  Dir.chdir(Git_dir)
  Dir.each_child do |dir|
    if File.directory?(dir) && !$data[:blacklisted].include?(dir)
      Dir.chdir(File.join(dir, '.git'))
      File.open('config', 'r') do |conf_file|
        conf_file.each_line do |lin|
          if lin.include?('url = ')
            url = lin.split(' ').last
          end # if lin has 'url = '
        end # each line of conf_file
      end # File.open gh config file / close the file
      gh_repos[dir.to_sym] = url.to_s
    else
      next
    end # if dir is a [directory] and isn't blasklisted
  end # each object in the directory less '.' and '..'

  $data[:git_repos]       = gh_repos
  $data[:vim_plugins]     = grep_vim_gits 

  File.open($data[:data_filename], 'w') {|f|
    f.write($data.to_yaml)
  }
end

def import_data_file # read in from data file
  File.open(Data_filename, 'r') {|f|
    $data = YAML::load_file(f)
  }
  if $data.nil?
    # yaml is empty then create it 
    create_data_file
  end
end


begin ###################### MAIN PROGRAM ######################
  # Order of events:
  #   if the data_file is empty :( start gathering info 
  #     -have an option to -update and regenerate the 'snap' of system
  #     -have an option to adjust the order of install
  #       -"awesome print" the array and enter which one you owuld like to change, then to which pos
  #   if data file isn't empty read it
  #   import_data_file
  #   create gh dir
  #   for each dir / repo in gh dir 
  #     clone
  #     copy over any files that are included in the dot-files repo (ie: fish functions)
  #     run install steps
  #       rescue any errors and log for final status report
  #   create vim dirs
  #   for each vimplugin
  #     clone plugin
  #       resuce and errors and log for final status report

end
