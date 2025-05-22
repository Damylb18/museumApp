using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using CMM_Admin.Data;
using CMM_Admin.Data.Models;
using CMM_Admin.Helpers;

namespace CMM_Admin.Pages.Artifacts;

public class CreateModel(MuseumContext context, ImageHandler imageHandler) : PageModel
{
    public IActionResult OnGet()
    {
        return Page();
    }

    [BindProperty] public Artifact Artifact { get; set; } = null!;

    public async Task<IActionResult> OnPostAsync()
    {
        if (!ModelState.IsValid)
            return Page();

        var imageCheckResult = imageHandler.CheckUpload(Request.Form.Files);
        if (!imageCheckResult.Success)
        {
            ModelState.AddModelError(string.Empty, imageCheckResult.ErrorMessage!);
            return Page();
        }
        var file = Request.Form.Files[0];

        // Create Artifact ID
        var id = Guid.NewGuid().ToString();
        Artifact.ArtifactId = id;
            
        // Upload image:
        var imageSaveResult = await imageHandler.SaveImage(file, id);
        if (!imageSaveResult.Success)
        {
            ModelState.AddModelError(string.Empty, imageSaveResult.ErrorMessage!);
            return Page();
        }

        Artifact.ImagePath = imageSaveResult.FilePath!;
        context.Artifacts.Add(Artifact);
        await context.SaveChangesAsync();

        return RedirectToPage("./Index");
    }
}