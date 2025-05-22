using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using CMM_Admin.Data;
using CMM_Admin.Data.Models;

namespace CMM_Admin.Pages.Artifacts
{
    public class IndexModel(MuseumContext context) : PageModel
    {
        public IList<Artifact> Artifact { get;set; } = null!;

        public async Task OnGetAsync()
        {
            Artifact = await context.Artifacts.ToListAsync();
        }
    }
}
