using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CMM_Admin.Data;
using CMM_Admin.Data.Models;

namespace CMM_Admin.Pages.Artifacts
{
    public class DetailsModel(MuseumContext context) : PageModel
    {
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
            else
            {
                Artifact = artifact;
            }
            return Page();
        }
    }
}
