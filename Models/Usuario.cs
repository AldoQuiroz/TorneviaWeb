namespace TorneviaWeb.Models
{
    public class Usuario
    {
        public int ID_Usuario { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Contrasena { get; set; } = string.Empty;
        public string Rol { get; set; } = string.Empty;
        public DateTime Fecha_Registro { get; set; }
    }
}