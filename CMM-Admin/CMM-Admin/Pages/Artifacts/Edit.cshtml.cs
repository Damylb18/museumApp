using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CMM_Admin.Data.Models;

namespace CMM_Admin.Pages.Artifacts
{
    public class EditModel(Data.MuseumContext context) : PageModel
    {
        [BindProperty]
        public Artifact Artifact { get; set; } = null!;

        public async Task<IActionResult> OnGetAsync(string? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var artifact =  await context.Artifacts.FirstOrDefaultAsync(m => m.ArtifactId == id);
            if (artifact == null)
            {
                return NotFound();
            }
            Artifact = artifact;
            return Page();
        }

        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more information, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            context.Attach(Artifact).State = EntityState.Modified;

            try
            {
                await context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ArtifactExists(Artifact.ArtifactId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToPage("./Index");
        }

        private bool ArtifactExists(string id)
        {
            return context.Artifacts.Any(e => e.ArtifactId == id);
        }
    }
}
