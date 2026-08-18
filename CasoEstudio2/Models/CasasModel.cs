namespace CasoEstudio2.Models
{
    public class CasasModel
    {
        public long IdCasa { get; set; }
        public string DescripcionCasa { get; set; } = string.Empty;
        public decimal PrecioCasa { get; set; }
        public string? UsuarioAlquiler { get; set; }
        public DateTime? FechaAlquiler { get; set; }
    }

    public class AlquilerCasaViewModel
    {
        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "Debe seleccionar una casa.")]
        [System.ComponentModel.DataAnnotations.Display(Name = "Casa")]
        public long? IdCasa { get; set; }

        [System.ComponentModel.DataAnnotations.Display(Name = "Precio mensual")]
        public decimal PrecioCasa { get; set; }

        [System.ComponentModel.DataAnnotations.Required(ErrorMessage = "Debe ingresar el usuario del alquiler.")]
        [System.ComponentModel.DataAnnotations.StringLength(30, ErrorMessage = "El usuario no puede superar los 30 caracteres.")]
        [System.ComponentModel.DataAnnotations.Display(Name = "Usuario del alquiler")]
        public string UsuarioAlquiler { get; set; } = string.Empty;

        public List<CasasModel> CasasDisponibles { get; set; } = new();
    }

    public class HomeModel
    {
    }
}
