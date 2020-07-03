using Microsoft.AspNetCore.Authorization;

namespace app.AuthorizationPolicies
{
    /// <summary>
    /// Client Certificate Authorization
    /// </summary>
    public class ClientCertificateRequirement : IAuthorizationRequirement
    {
    }
}