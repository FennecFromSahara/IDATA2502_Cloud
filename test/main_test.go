package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformGoogleCloudInstance(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../src",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	externalIP := terraform.Output(t, terraformOptions, "external_ip")

	url := fmt.Sprintf("http://%s:80", externalIP)
	http_helper.HttpGetWithRetry(t, url, nil, 200, "<!doctype html><html><body><h1>The default webpage has been changed D:</h1></body></html>", 30, 5*time.Second)
}
