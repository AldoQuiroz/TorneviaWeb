namespace TorneviaWeb.Models
{
    public class TorneoEquipo
    {
        public int ID_Torneo { get; set; }
        public int ID_Equipo { get; set; }
        public DateTime Fecha_Inscripcion { get; set; }

        public Torneo? Torneo { get; set; }
        public Equipo? Equipo { get; set; }
    }
}