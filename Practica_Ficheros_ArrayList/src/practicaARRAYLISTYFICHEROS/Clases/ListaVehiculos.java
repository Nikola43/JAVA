package practicaARRAYLISTYFICHEROS.Clases;
/*
ListaVehiculos: esta clase tiene como atributo un arrayList de tipo Vehiculo, donde estarán
guardados todos los vehículos registrados en la empresa de Rent a Car. El constructor vuelca
de un fichero llamado “vehiculos” todos los objetos que contiene al atributo ArrayList (si el
fichero está vacío o no existe, no pasa ningún objeto, evidentemente), mostrando un mensaje
de éxito en el paso al arrayList de los objetos o un mensaje de fracaso en caso de no poder
pasarlo. Otros métodos que contiene la clase ListaClientes son (hasta aquí 0.25 puntos):

 alta: recibe como parámetro un objeto tipo Vehiculo, si la matrícula del vehículo ya se
encuentra registrada en el arrayList devuelve FALSE, en caso contrario, inserta el
vehículo y devuelve true. (0.25 puntos)

 existeVehiculo: devuelve true o false en caso que el vehículo exista en la lista de
vehíciulos. Es necesario el uso de iteradores para recorrer el arrayList.

 baja: se le pasa como parámetro una matrícula y en caso que exista y no esté
alquilado, lo elimina y devuelve true. Si el vehículo no existe en la lista o está alquilado
a algún cliente, devolverá false. Es necesario el uso de iteradores para recorrer el
arrayList. (0.25 puntos)

 toString(): pregunta al usuario por la matrícula del vehículo. Busca dicho vehículo
(haciendo uso de iteradores) y si lo encuentra guarda en la cadena que devuelve los
datos del vehículo precedido de “EL VEHÍCULO ES UN COCHE” o “EL VEHÍCULO ES UNA
FURGONETA” según el tipo de vehículo que sea. Si el vehículo con esa matrícula no
existe, devuelve una cadena indicando que el vehículo no existe.

 getVehiculo: devuelve el objeto Vehiculo que corresponde con la matrícula pasada
como parámetro. Si no lo encuentra, devuelve null. Es necesario el uso de iteradores
para recorrer el arrayList.

 mueveDatosAFichero():mueve todos los datos del arrayList al fichero “vehiculos” (no
añade datos, sino que machaca el fichero). Devuelve mensajes en caso de éxito en
pasar los datos al fichero, de que haya un fallo o de que ocurra un error al cerrar el
fichero. Es necesario el uso de iteradores para recorrer el arrayList (0.25 puntos)

 listarVehiculos: no recibe parámetros. Pregunta al usuario si quiere listar todos los
vehículos, sólo los coches o solo las furgonetas. Muestra los datos correspondientes en
función de la decisión del usuario. (0.25 puntos)
 */
public class ListaVehiculos {
}
