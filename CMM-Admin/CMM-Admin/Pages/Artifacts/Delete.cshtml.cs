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
    public class DeleteModel : PageModel
    {
        private readonly CMM_Admin.Data.MuseumContext _context;

        public DeleteModel(CMM_Admin.Data.MuseumContext context)
        {
            _context = context;
        }

        [BindProperty]
        public Artifact Artifact { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var artifact = await _context.Artifacts.FirstOrDefaultAsync(m => m.ArtifactId == id);

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

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var artifact = await _context.Artifacts.FindAsync(id);
            if (artifact != null)
            {
                Artifact = artifact;
                _context.Artifacts.Remove(Artifact);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
