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
using Microsoft.IdentityModel.Tokens;

namespace CMM_Admin.Pages.Artifacts
{
    public class CreateModel : PageModel
    {
        private readonly CMM_Admin.Data.MuseumContext _context;

        public CreateModel(CMM_Admin.Data.MuseumContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        [BindProperty] public Artifact Artifact { get; set; } = default!;

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            if (Request.Form.Files.IsNullOrEmpty())
            {
                ModelState.AddModelError(string.Empty, "No image file selected");
                return Page();
            }

            var file = Request.Form.Files[0];
            var extension = Path.GetExtension(file.FileName);
            List<string> validExtensions = [".jpg", ".png"];

            if (!validExtensions.Contains(extension))
            {
                var builder = new StringBuilder();
                foreach (var str in validExtensions)
                {
                    builder.Append(str + " ");
                }

                var validExtensionsString = builder.ToString();
                ModelState.AddModelError(string.Empty,
                    $"Invalid file ({extension}). Accepted formats are {validExtensionsString}");
                return Page();
            }


            _context.Artifacts.Add(Artifact);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}