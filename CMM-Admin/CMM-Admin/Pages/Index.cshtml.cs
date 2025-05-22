using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace CMM_Admin.Pages;

public class IndexModel(ILogger<IndexModel> logger) : PageModel
{
    private readonly ILogger<IndexModel> _logger = logger;

    public IActionResult OnGet()
    {
        return RedirectToPage("/Artifacts/Index");
    }
}