module ApkToJava
  class Setup
    JADX_URL = "'https://drive.google.com/uc?id=0BxXHKToe2BBtMGZMQXR5NFhGSUE&export=download'"

    def download_jadx
      "wget --no-check-certificate #{JADX_URL} -O jadx.zip && sudo unzip jadx.zip -d jadx/ && rm jadx.zip"
    end

    def jadx_installed?
      File.exists? self.class::JADX
    end

    def dex_to_jar_installed?
      File.exists? self.class::DEX_TO_JAR
    end

    def env_setup?
      dex_to_jar_installed? && jadx_installed?
    end

    def wget_present?
      !find_executable('wget').nil?
    end

    def curl_present?
      !find_executable('curl').nil?
    end
  end
end
