namespace TorneviaWeb.Models
{
    public class Estadistica
    {
        public int ID_Estadistica { get; set; }
        public int ID_Partido { get; set; }
        public int ID_Jugador { get; set; }
        public int Goles { get; set; }
        public int Asistencias { get; set; }
        public int Tarjetas_Amarillas { get; set; }
        public int Tarjetas_Rojas { get; set; }
        public int Minutos_Jugados { get; set; }

        public Partido? Partido { get; set; }
        public Jugador? Jugador { get; set; }
    }
}