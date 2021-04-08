class Aepctl < Formula
    desc "AEP command line interface"
    homepage "https://www.bungenstock.de/aepctl/"
    url  "https://github.com/fuxs/aepctl.git",
      :tag => "v0.2.1",
      :revision => "a293cf1666cea89cd8f005f1bd08b7f274ee0c7f"
    license "Apache-2.0"
    version "v0.2.1"
  
    livecheck do
      url :head
      regex(/^v([\d.]+)$/i)
    end
  
    depends_on "go" => :build
    
    def install
      # Build
      system "make","build"
      bin.install "bin/aepctl"
  
      # bash completion
      output = Utils.safe_popen_read("#{bin}/aepctl", "completion", "bash")
      (bash_completion/"aepctl").write output
  
      # zsh completion
      output = Utils.safe_popen_read("#{bin}/aepctl", "completion", "zsh")
      (zsh_completion/"_aepctl").write output
    end
  
    test do
      run_output = shell_output("#{bin}/aepctl 2>&1")
      assert_match "The command line tool for AEP", run_output
    end
  end