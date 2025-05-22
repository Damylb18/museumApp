using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CMM_Admin.Data;
using CMM_Admin.Data.Models;
using QRCoder;

namespace CMM_Admin.Pages.Artifacts
{
    public class DetailsModel(MuseumContext context) : PageModel
    {
        public Artifact Artifact { get; set; } = null!;
        public string? QrCodeBase64 { get; set; }

        public async Task<IActionResult> OnGetAsync(string? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var artifact = await context.Artifacts.FirstOrDefaultAsync(m => m.ArtifactId == id);
            if (artifact == null)
            {
                return NotFound();
            }

            Artifact = artifact;


            using var qrGenerator = new QRCodeGenerator();
            using var qrData = qrGenerator.CreateQrCode(Artifact.ArtifactId, QRCodeGenerator.ECCLevel.M);
            using var qrCode = new PngByteQRCode(qrData);

            var qrCodeBytes = qrCode.GetGraphic(20);
            QrCodeBase64 = Convert.ToBase64String(qrCodeBytes);
            
            return Page();
        }
    }
}
