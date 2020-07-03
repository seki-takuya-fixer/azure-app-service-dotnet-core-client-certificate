$rootDnsName = "root_ca_sample.com"
$clientDnsName = "client_sample.com"
$pwd = ConvertTo-SecureString -String "1234" -Force -AsPlainText
$rootCert = New-SelfSignedCertificate -DnsName $rootDnsName -CertStoreLocation "Cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(20) -FriendlyName $rootDnsName -KeyUsageProperty All -KeyUsage CertSign, CRLSign, DigitalSignature
$rootCert | Export-PfxCertificate -FilePath "${rootDnsName}.pfx" -Password $pwd
Export-Certificate -Cert $rootCert -FilePath "${rootDnsName}.crt"
$clientCert = New-SelfSignedCertificate -certstorelocation "Cert:\CurrentUser\My" -dnsname $clientDnsName -Signer $rootCert -NotAfter (Get-Date).AddYears(20) -FriendlyName $clientDnsName
$clientCert | Export-PfxCertificate -FilePath "${clientDnsName}.pfx" -Password $pwd
Export-Certificate -Cert $clientCert -FilePath "${clientDnsName}.crt"