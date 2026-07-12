namespace TorneviaWeb.Models
{
    public class Torneo
    {
        public int ID_Torneo { get; set; }
        public string Nombre { get; set; } = string.Empty;
        public string Tipo { get; set; } = string.Empty;
        public DateTime Fecha_Inicio { get; set; }
        public DateTime? Fecha_Fin { get; set; }
        public string Estado { get; set; } = string.Empty;
        public int ID_Administrador { get; set; }

        public Usuario? Administrador { get; set; }
    }
}