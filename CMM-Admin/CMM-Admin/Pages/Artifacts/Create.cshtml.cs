using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using CMM_Admin.Data;
using CMM_Admin.Data.Models;
using CMM_Admin.Helpers;
using Microsoft.IdentityModel.Tokens;
using Microsoft.VisualBasic;

namespace CMM_Admin.Pages.Artifacts
{
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

            var errorMessage = imageHandler.CheckUpload(Request.Form.Files);
            if (!errorMessage.IsNullOrEmpty())
            {
                ModelState.AddModelError(string.Empty, errorMessage);
                return Page();
            }

            context.Artifacts.Add(Artifact);
            await context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}