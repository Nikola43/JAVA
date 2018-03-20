public class Test_Conductor {
    public static void main(String  []Args)
    {
        //Instaciamos un objeto de la clase conductor
        Conductor conductor = new Conductor("4545656K", "pepe", "asecas", "Sevilla");

        //Testeamos getters
        System.out.println("TESTEAMOS GETTERS");
        System.out.println(
                   conductor.getDni()+"\n"+
                   conductor.getNombre()+"\n"+
                   conductor.getApellidos()+"\n"+
                   conductor.getCiudadAlojamiento()+"\n"+
                   conductor.getKmMes()+"\n\n"
        );

        //Testeamos setters
        System.out.println("TESTEAMOS SETTERS");
        conductor.setDni("4547678D");
        conductor.setNombre("Roberto");
        conductor.setApellidos("Baus");
        conductor.setCiudadAlojamiento("Malaga");
        conductor.setKmMes(23);

        System.out.println(
                        conductor.getDni()+"\n"+
                        conductor.getNombre()+"\n"+
                        conductor.getApellidos()+"\n"+
                        conductor.getCiudadAlojamiento()+"\n"+
                        conductor.getKmMes()
        );

        System.out.println("TESTEAMOS METODOS AÑADIDOS");
        System.out.println("TESTEAMOS METODOS mostrarDatosConductor");
        conductor.mostrarDatosConductor();
        System.out.println();

        System.out.println("TESTEAMOS METODOS anyadeKilometros");
        System.out.println(conductor.getKmMes());
        conductor.anyadeKilometros(45);
        System.out.println(conductor.getKmMes()+"\n\n");

        System.out.println("TESTEAMOS METODOS puedeHacerKilometros");
        System.out.println(conductor.puedeHacerKilometros(567)+"\n");

        System.out.println(conductor.puedeHacerKilometros(23)+"\n");

        System.out.println("TESTEAMOS METODOS getKmMes");
        conductor.reiniciaKmMes();
        System.out.println(conductor.getKmMes());
    }
}
