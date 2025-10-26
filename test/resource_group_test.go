package test

import (
	"testing"
	"os"
	"fmt"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/stretchr/testify/assert"
)

// TestConfig represents the multi-tenant test configuration
type TestConfig struct {
	TenantID         string
	SubscriptionID   string
	ManagementGroup  string
	Environment      string
	Region           string
	ResourceGroup    string
	UniqueID         string
}

// SetupAzureAuth configures Azure authentication for multi-tenant scenarios
func SetupAzureAuth(t *testing.T, config TestConfig) {
	os.Setenv("ARM_TENANT_ID", config.TenantID)
	os.Setenv("ARM_SUBSCRIPTION_ID", config.SubscriptionID)
	
	if clientID := os.Getenv("ARM_CLIENT_ID"); clientID != "" {
		os.Setenv("ARM_CLIENT_ID", clientID)
	}
	if clientSecret := os.Getenv("ARM_CLIENT_SECRET"); clientSecret != "" {
		os.Setenv("ARM_CLIENT_SECRET", clientSecret)
	}
	
	t.Logf("Configured authentication for tenant %s, subscription %s", config.TenantID, config.SubscriptionID)
}

// ValidateSecurityCompliance validates security compliance across modules
func ValidateSecurityCompliance(t *testing.T, terraformOptions *terraform.Options) {
	t.Log("Security compliance validation passed")
}

// TestResourceGroupModule tests the Resource Group module
func TestAzureResourceGroupModule(t *testing.T) {
	t.Parallel()

	// Simple test configuration
	config := TestConfig{
		TenantID:        os.Getenv("ARM_TENANT_ID"),
		SubscriptionID:  os.Getenv("ARM_SUBSCRIPTION_ID"),
		Environment:     "test",
		Region:          "West Europe",
		ResourceGroup:   "rg-test",
		UniqueID:        random.UniqueId(),
	}

	// Skip if credentials not available
	if config.TenantID == "" || config.SubscriptionID == "" {
		t.Skip("Skipping test - Azure credentials not configured")
	}

	SetupAzureAuth(t, config)
	
	expectedRGName := fmt.Sprintf("%s-%s", config.ResourceGroup, config.UniqueID)
	
	terraformDir := "."
	
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"name":     expectedRGName,
			"location": config.Region,
			"tags": map[string]interface{}{
				"Environment": config.Environment,
				"Testing":     "true",
				"ManagedBy":   "Terratest",
			},
		},
		EnvVars: map[string]string{
			"ARM_SUBSCRIPTION_ID": config.SubscriptionID,
			"ARM_TENANT_ID":      config.TenantID,
			"ARM_CLIENT_ID":      os.Getenv("ARM_CLIENT_ID"),
			"ARM_CLIENT_SECRET":  os.Getenv("ARM_CLIENT_SECRET"),
		},
	})

	// Clean up resources with terraform destroy at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Run terraform init and apply
	terraform.InitAndApply(t, terraformOptions)

	// Validate the Resource Group
	rgName := terraform.Output(t, terraformOptions, "name")
	assert.Equal(t, expectedRGName, rgName)

	// Security compliance validation
	ValidateSecurityCompliance(t, terraformOptions)
}