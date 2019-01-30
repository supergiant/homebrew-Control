class Control < Formula
  desc "Control manages the lifecycle of clusters on your infrastructure and allows deployment of applications via HELM. Its deployment and configuration workflows will help you to get up and running with Kubernetes faster."
  homepage "https://supergiant.io/toolkit/"
  url "https://github.com/supergiant/control/archive/v2.0.0-rc.3.tar.gz"
  sha256 "155c6e481821be0aa332d9a207d1874a6744729cfeafe8c3bf59608898ea110f"

  depends_on "docker" => :build

  def install
    mkdir_p buildpath/"src/github.com/supergiant"
    system 'docker-compose pull'
    system 'docker-compose up \-d \; sleep 3 \; echo'
    system 'docker ps --filter \"name=sg-control\" \-\-format \"table \{\{\.ID\}\}\t\{\{\.Names\}\}\t\{\{\.Status\}\}\" \; echo'
    system 'docker-compose logs \| grep pass \| awk \'\{print $10,$14\}\' \| tee login.txt \; echo'
    system 'cat login.txt'
    system 'open \"http://localhost:8080\"'
  end

  def uninstall
    system 'docker-compose down'
    system 'echo \"Live long and prosper\"'

  end
  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test control`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
