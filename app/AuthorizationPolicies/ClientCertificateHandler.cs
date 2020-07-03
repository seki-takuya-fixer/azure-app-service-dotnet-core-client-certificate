using System;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace app.AuthorizationPolicies
{
    /// <summary>
    /// Client Certificate Authorization Handler
    /// </summary>
    public class ClientCertificateHandler : AuthorizationHandler<ClientCertificateRequirement>
    {
        readonly IHttpContextAccessor _httpContextAccessor = null;

        public ClientCertificateHandler(IHttpContextAccessor httpContextAccessor)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        protected override Task HandleRequirementAsync(AuthorizationHandlerContext context, ClientCertificateRequirement requirement)
        {
            HttpContext httpContext = _httpContextAccessor.HttpContext;

            var validationService = httpContext.RequestServices.GetService<MyCertificateValidationService>();

            var certificate = httpContext.Connection.ClientCertificate;
            if (certificate == null)
            {
                var certHeader = httpContext.Request.Headers["X-ARR-ClientCert"];
                if (!string.IsNullOrEmpty(certHeader))
                {
                    try
                    {
                        byte[] clientCertBytes = Convert.FromBase64String(certHeader);
                        certificate = new X509Certificate2(clientCertBytes);
                    }
                    catch (Exception)
                    {

                    }
                }
            }
            if (validationService.ValidateCertificate(certificate))
            {
                context.Succeed(requirement);
            }
            else
            {
                context.Fail();
            }
            return Task.CompletedTask;
        }
    }
}