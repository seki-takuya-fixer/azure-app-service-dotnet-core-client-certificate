using System.IO;
using System.Security.Cryptography.X509Certificates;

namespace app.AuthorizationPolicies
{
    /// <summary>
    /// Validate Client Certification
    /// </summary>
    public class MyCertificateValidationService
    {
        public bool ValidateCertificate(X509Certificate2 clientCertificate)
        {
            // TODO:You need to fix the validation logic
            var cert = new X509Certificate2(Path.Combine("Certs/client_sample.com.pfx"), "1234");
            if (clientCertificate != null && clientCertificate.Thumbprint == cert.Thumbprint)
            {
                return true;
            }

            return false;
        }
    }
}