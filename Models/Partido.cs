namespace TorneviaWeb.Models
{
    public class Partido
    {
        public int ID_Partido { get; set; }
        public int ID_Torneo { get; set; }
        public DateTime Fecha { get; set; }
        public int Equipo_Local { get; set; }
        public int Equipo_Visitante { get; set; }
        public int Goles_Local { get; set; }
        public int Goles_Visitante { get; set; }
        public string? Lugar { get; set; }
        public string Estado { get; set; } = string.Empty;

        public Torneo? Torneo { get; set; }
    }
}