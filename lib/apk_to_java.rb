require_relative 'apk_to_java/pretty_printer'

module ApkToJava
  include ApkToJava::PrettyPrinter
  DEX_TO_JAR = '/usr/local/Cellar/dex2jar/2.0/bin/d2j-dex2jar'
  JADX = '/usr/local/Cellar/jadx/bin/jadx-gui'

  module Setup
    def install_dex2jar
      print_info("Installing dex2jar..")
      `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null && brew install dex2jar`
      print_success "Done!"
    end

    def install_jadx
      print_info("Installing jadx..")
      `cd /usr/local/Cellar && wget https://github.com/skylot/jadx/releases/download/v0.6.0/jadx-0.6.0.zip && unzip jadx-0.6.0.zip -d jadx/ && rm jadx-0.6.0.zip && cd -`
      print_success "Done!"
    end

    def jadx_installed?
      File.exists? ApkToJava::JADX
    end

    def dex_to_jar_installed?
      File.exists? ApkToJava::DEX_TO_JAR
    end

    def env_setup?
      dex_to_jar_installed? && jadx_installed?
    end

    def initialize_setup
      print_info("Initializing setup!!")
      install_dex2jar if !dex_to_jar_installed?
      install_jadx if !jadx_installed?
      print_success("Setup done :)")
    end
  end

  module Operations
    TEMP_DIR = 'apkToJavaTmp'

    def copy_apk(apk)
      `mkdir #{TEMP_DIR}`
      `cp #{apk} #{TEMP_DIR}/`
    end

    def unzip(apk_name)
      `mv #{TEMP_DIR}/#{apk_name}.apk #{TEMP_DIR}/#{apk_name}.zip`
      `unzip #{TEMP_DIR}/#{apk_name}.zip -d #{TEMP_DIR}/`
    end

    def create_dex
      `#{ApkToJava::DEX_TO_JAR} #{TEMP_DIR}/classes.dex`
    end

    def path_to_dex
      `pwd`.chomp + "/#{TEMP_DIR}/classes.dex"
    end

    def create_jar(dex_file)
      `#{ApkToJava::DEX_TO_JAR} #{dex_file} --force`
    end

    def path_to_jar
      `pwd`.chomp + '/classes-dex2jar.jar'
    end

    def clean_up
      print_info "Cleaning the mess.."
      `rm -rf #{TEMP_DIR}`
      print_success "done!"
    end

    def open_code_in_gui(jar_file)
      `#{ApkToJava::JADX}  #{jar_file} &`
    end

    def convert_to_dex(apk)
      print_info "Converting to dex.."
      copy_apk apk
      apk_name = apk.split('/').last.split('.').first
      unzip apk_name
      create_dex
      print_success "Done!"
      path_to_dex
    end

    def dex_to_jar(apk)
      dex_file = convert_to_dex apk
      print_info "Converting dex to jar.."
      create_jar dex_file
      print_success "Done!"
      path_to_jar
    end

    def view_as_java_code(apk)
      jar_file = dex_to_jar apk
      clean_up
      print_info "Opening in gui interface.."
      print_success "Please be patient, apkToJava might take some time to load your project in gui interface"
      open_code_in_gui jar_file
    end
  end
end
