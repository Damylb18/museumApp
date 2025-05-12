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
    public class IndexModel(CMM_Admin.Data.MuseumContext context) : PageModel
    {
        public IList<Artifact> Artifact { get;set; } = null!;

        public async Task OnGetAsync()
        {
            Artifact = await context.Artifacts.ToListAsync();
        }
    }
}
