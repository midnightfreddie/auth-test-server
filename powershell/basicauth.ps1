# Example to use Powershell to authenticate against a Basic Auth resource
# Requires Powershell v3 or later

# Accepts a Uri and a PSCredential object
# Since this is an auth test against a test server, defaulting to the known username/password
# Normally you would create a credential object with Get-Credential

# Apparently using -Credential does not work against some Basic Auth servers
# that fail if the auth header isn't sent on the first request. In those
# cases, build the auth header manually as shown in basicauth-header.ps1

[cmdletbinding()]
param (
  $Uri = "http://192.168.1.73:32774/basicauth/stuff.json",
  $Credential = (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "authtestusername",  ("authtestpassword" | ConvertTo-SecureString -AsPlainText -Force ))
)

Invoke-RestMethod -Uri $Uri -Credential $Credential
