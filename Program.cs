using Microsoft.EntityFrameworkCore;
using TorneviaWeb.Models;
using TorneviaWeb.Components;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();
builder.Services.AddDbContext<TorneviaDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("TorneviaConnection")));
builder.Services.AddScoped<PasswordHasherService>();
builder.Services.AddScoped<SesionUsuario>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
