package practicaHERENCIAYPOLIMORFISMO.Interfaces;

public interface IMovible {
    boolean avanzarEjeX(int sumX, int fronteraX);
    boolean avanzarEjeY(int sumY, int fronteraY);
    boolean retrocederEjeX(int resX, int fronteraNegativaX);
    boolean retrocederEjeY(int resY, int fronteraNegativaY);
}
