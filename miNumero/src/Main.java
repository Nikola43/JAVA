public class Main {
    public static void main(String... args)
    {
        //Creamos una instancia del la clase MiNumero
        MiNumero numero = new MiNumero(3);

        //Testeamos getters y setters
        System.out.println("Mi numero: "+numero.getNumero());
        numero.setNumero(2);
        System.out.println("Mi numero despues de set: "+numero.getNumero());

        //Testeamos los metodos que hemos añadido a la clase
        System.out.println("Doble: "+numero.devolverDoble());
        System.out.println("Triple: "+numero.devolverTriple());
        System.out.println("Cuadruple: "+numero.devolverCuadruple());
        System.out.println("Multiplicador: "+numero.devolverNumeroMultiplicado(5));
    }
}
