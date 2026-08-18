using CasoEstudio2.Data;
using CasoEstudio2.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace CasoEstudio2.Controllers
{
    public class CasasController : Controller
    {
        private readonly CasoEstudioContext _context;

        public CasasController(CasoEstudioContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Consultar()
        {
            try
            {
                // Parámetros: Precio mínimo 115.000 y máximo 180.000
                var precioMinimo = Convert.ToDecimal(115000);
                var precioMaximo = Convert.ToDecimal(180000);

                // Llamar al SP sp_ObtenerCasasPorRangoPrecio
                var casas = await _context.CasasSistema
                    .FromSqlInterpolated($"EXEC sp_ObtenerCasasPorRangoPrecio @PrecioMinimo={precioMinimo}, @PrecioMaximo={precioMaximo}")
                    .ToListAsync();

                // Ordenar: Disponibles primero (UsuarioAlquiler IS NULL), luego por precio
                var casasOrdenadas = casas
                    .OrderBy(c => string.IsNullOrEmpty(c.UsuarioAlquiler) ? 0 : 1)
                    .ThenBy(c => c.PrecioCasa)
                    .ToList();

                return View(casasOrdenadas);
            }
            catch (Exception ex)
            {
                // En caso de error, mostrar mensaje
                ViewBag.Error = "Error al obtener las casas: " + ex.Message;
                return View(new List<CasasModel>());
            }
        }

        [HttpGet]
        public async Task<IActionResult> Alquilar()
        {
            var modelo = new AlquilerCasaViewModel();
            await CargarCasasDisponibles(modelo);
            return View(modelo);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Alquilar(AlquilerCasaViewModel modelo)
        {
            if (string.IsNullOrWhiteSpace(modelo.UsuarioAlquiler))
                ModelState.AddModelError(nameof(modelo.UsuarioAlquiler), "Debe ingresar el usuario del alquiler.");

            if (modelo.IdCasa.HasValue)
            {
                var casa = await _context.CasasSistema.AsNoTracking()
                    .FirstOrDefaultAsync(c => c.IdCasa == modelo.IdCasa.Value && c.UsuarioAlquiler == null);

                if (casa == null)
                    ModelState.AddModelError(nameof(modelo.IdCasa), "La casa seleccionada ya no está disponible.");
                else
                    modelo.PrecioCasa = casa.PrecioCasa;
            }

            if (!ModelState.IsValid)
            {
                await CargarCasasDisponibles(modelo);
                return View(modelo);
            }

            await _context.Database.ExecuteSqlInterpolatedAsync(
                $"EXEC sp_AlquilarCasa @IdCasa={modelo.IdCasa!.Value}, @UsuarioAlquiler={modelo.UsuarioAlquiler.Trim()}");

            TempData["Mensaje"] = "La casa fue alquilada correctamente.";
            return RedirectToAction(nameof(Consultar));
        }

        private async Task CargarCasasDisponibles(AlquilerCasaViewModel modelo)
        {
            var casas = await _context.CasasSistema
                .FromSqlRaw("EXEC sp_ObtenerCasasDisponibles")
                .AsNoTracking()
                .ToListAsync();

            modelo.CasasDisponibles = casas;
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
