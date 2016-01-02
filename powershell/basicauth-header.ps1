# Example to use Powershell to authenticate against a Basic Auth resource
# Requires Powershell v3 or later

# Accepts a Uri, username and password
# Since this is an auth test against a test server, defaulting to the known username/password

# Using -Credential as in basicauth.ps1 is the "right" Powershell way to do things,
#  but for some servers it may not work if they expect the basic auth header
#  to be sent upon the first request and won't negotiate authentication.
#  But the Basic Auth header is simple enough to build and send with Powershell
#  As shown below

[cmdletbinding()]
param (
  $Uri = "http://authtest.midnightfreddie.com/basicauth/stuff.json",
  $Username = "authtestusername",
  $Password = "authtestpassword"
)

# Function accepts uername and password, returns a hash to be used as a
#  -Headers parameter for an Invoke-RestMethod or Invoke-WebRequest
function New-BasicAuthHeader {
  [cmdletbinding()]
  param (
    [Parameter(Mandatory=$true)] $Username,
    [Parameter(Mandatory=$true)] $Password
  )
  # Doing this step-by-step for illustration; no reason not to reduce it to fewer steps
  # In fact, you can uncomment the following line and remove all the following lines in the function
  # @{ Authorization = "Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Username,$Password))) }

  # Make "username:password" string
  $UserNameColonPassword = "{0}:{1}" -f $Username,$Password
  # Could also be accomplished like:
  # $UserNameColonPassword = "$($Username):$($Password)"

  # Ensure it's ASCII-encoded
  $InAscii = [Text.Encoding]::ASCII.GetBytes($UserNameColonPassword)

  # Now Base64-encode:
  $InBase64 = [Convert]::ToBase64String($InAscii)

  # The value of the Authorization header is "Basic " and then the Base64-encoded username:password
  $Authorization = "Basic {0}" -f $InBase64
  # Could also be done as:
  # $Authorization = "Basic $InBase64"

  #This hash will be returned as the value of the function and is the Powershell version of the basic auth header
  $BasicAuthHeader = @{ Authorization = $Authorization }

  # Return the header
  $BasicAuthHeader
}

$Headers = New-BasicAuthHeader -Username $Username -Password $Password

Invoke-RestMethod -Uri $Uri -Headers $Headers
