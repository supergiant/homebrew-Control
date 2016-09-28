class Supergiant < Formula
  desc "An Application platform specializing in stateful container orchestration, based on Kubernetes."
  homepage "https://supergiant.io/"
  url "https://github.com/supergiant/supergiant/archive/v0.10.2.tar.gz"
  version "0.10.2"
  sha256 "29b014bd699cef697f90bed9e7b6f2e0252f22cd022157303a42758422aa9aec"

  head "https://github.com/supergiant/supergiant.git"


  depends_on "go" => :build
  depends_on "govendor" => :recommended

  def install

    mkdir_p buildpath/"src/github.com/supergiant"

    system "cp config/config.json.example config/config.json"
    system "go run cmd/generate_admin_user/generate_admin_user.go --config-file config/config.json"

  end

  test do
    output = shell_output(bin/"supergiant --version")
    assert_match "supergiant version #{version} (HEAD)", output
  end
end
