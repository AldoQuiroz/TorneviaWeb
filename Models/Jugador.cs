namespace TorneviaWeb.Models
{
    public class Jugador
    {
        public int ID_Jugador { get; set; }
        public string Nombre_Jugador { get; set; } = string.Empty;
        public string? Posicion { get; set; }
        public int? Numero_Camiseta { get; set; }
        public int ID_Equipo { get; set; }
        public int? ID_Usuario { get; set; }

        public Equipo? Equipo { get; set; }
        public Usuario? Usuario { get; set; }
    }
}