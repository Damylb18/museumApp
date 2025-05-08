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
    public class IndexModel : PageModel
    {
        private readonly CMM_Admin.Data.MuseumContext _context;

        public IndexModel(CMM_Admin.Data.MuseumContext context)
        {
            _context = context;
        }

        public IList<Artifact> Artifact { get;set; } = default!;

        public async Task OnGetAsync()
        {
            Artifact = await _context.Artifacts.ToListAsync();
        }
    }
}
