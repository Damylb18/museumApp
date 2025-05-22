using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CMM_Admin.Data;
using CMM_Admin.Data.Models;

namespace CMM_Admin.Pages.Artifacts;

public class DeleteModel(MuseumContext context) : PageModel
{
    [BindProperty]
    public Artifact Artifact { get; set; } = null!;

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
        return Page();
    }

    public async Task<IActionResult> OnPostAsync(string? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var artifact = await context.Artifacts.FindAsync(id);
        if (artifact == null) return RedirectToPage("./Index");
        Artifact = artifact;
        context.Artifacts.Remove(Artifact);
        await context.SaveChangesAsync();

        return RedirectToPage("./Index");
    }
}