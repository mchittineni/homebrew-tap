class TfArch < Formula
  desc "Turn Terraform plans into cloud architecture diagrams (AWS, GCP, Azure)"
  homepage "https://github.com/mchittineni/tf-arch-diagram-generator"
  url "https://registry.npmjs.org/tf-arch-diagram-generator/-/tf-arch-diagram-generator-1.4.1.tgz"
  sha256 "3a01dd9795af162fad5669ead16ee6b094a4f9d2c02ce9789ce63b45a7bbbf84"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_equal "1.4.1", shell_output("#{bin}/tf-arch --version").strip

    (testpath/"plan.json").write <<~JSON
      {
        "format_version": "1.2",
        "resource_changes": [
          {
            "address": "aws_vpc.main",
            "type": "aws_vpc",
            "name": "main",
            "provider_name": "registry.terraform.io/hashicorp/aws",
            "change": { "actions": ["create"], "before": null, "after": { "cidr_block": "10.0.0.0/16" } }
          }
        ]
      }
    JSON

    system bin/"tf-arch", "render", "plan.json", "--out", "arch.svg", "--title", "Brew"
    assert_match "<svg", (testpath/"arch.svg").read
    assert_match "Brew", (testpath/"arch.svg").read
  end
end
