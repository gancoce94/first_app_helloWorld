=begin

¿Qué es ActiveRecord?
Active Record es una clase para la administración y 
funcionamiento de los modelos. Esta clase proporciona
la capa objeto-relacional que sigue rigurosamente el 
estándar ORM (Tablas en Clases, Registros en Objetos, 
y Campos en Atributos), facilita el entendimiento 
del código asociado a base de datos y encapsula la 
lógica específica haciéndola más fácil de usar para 
nosotros los programadores.

Ventajas del ActiveRecord
-Manejo de entidades con objetos de Ruby.
-Las acciones del CRUD (Insertar, leer, modificar y 
eliminar) están encapsuladas así que se reduce el 
código y se hace más fácil de comprender.
-Código fácil de entender y mantener
-Se reduce el uso de código SQL considerablemente 
lo que implica sierta independencia del manejador 
de base de datos que usamos.

FIND
usuario = Usuario.find(10)
que en sql sería
SELECT * FROM usuarios WHERE usuarios.id = 10 LIMIT 1

TAKE
usuario = Usuario.take
que en sql sería
SELECT * FROM usuarios LIMIT 1

FIRST & LAST
primer objeto de la tabla
usuario = Usuario.first
ultimo Objeto de la lista
usuario = Usuario.last
que en sql seria
# primer objeto de la tabla
SELECT * FROM usuarios ORDER BY usuarios.id ASC LIMIT 1
# ultimo Objeto de la lista
SELECT * FROM usuarios ORDER BY usuarios.id DESC LIMIT 1

FIND_BY
Usuario.find_by nombre: 'Ricardo', apellido: 'Sampayo'
que en sql sería
SELECT * FROM usuarios WHERE nombre = 'Ricardo' and  apellido = 'Sampayo' LIMIT 1

ALL
usuarios = Usuario.all
que en sql sería
SELECT * FROM usuarios

FIND_EACH
El find_each método recupera un lote de registros y a continuación 
podemos manipular cada uno de los registros de forma individual. 
Este proceso ocurre hasta que haya procesado todos los objetos.
# por defecto este primer ejemplo nos da los primeros 1000 registros
Usuario.find_each do |user|
. . . # se manipula cada uno de los objetosend
# En este otro ejemplo se extraen 5000 registros partiendo del usuario con identificador 15
Usuario.find_each(start: 15, batch_size: 5000) do |user|
. . . # se manipula cada uno de los objetos
end

CONDICIONES
# todos los usuarios que se llamen Ricardo
usuarios = Usuario.where("nombre = 'Ricardo'")
#todos los usuarios que su nombre comience por Ri
usuarios = Usuario.where("nombre LIKE 'Ri%'")
que en sql sería
# todos los usuarios que se llamen Ricardo
SELECT * FROM usuarios WHERE nombre = 'Ricardo';
#todos los usuarios que su nombre comience por Ri
SELECT * FROM usuarios WHERE nombre like 'Ri%' ;
------------------------------------------------
# todos los usuarios que se llamen Ricardo
Usuario.where("nombre = ?", 'Ricardo')
# todos los usuarios mayores de 18 y menores de 50 años
Usuario.where("edad >= :init_edad AND edad <= :fin_edad", {init_edad: 18, fin_edad: 50})
que en sql sería
SELECT * FROM usuarios WHERE nombre = 'Ricardo';
SELECT * FROM usuarios WHERE edad >= 18 and edad <= 50;
------------------------------------------------
# todos los usuarios que se llamen Ricardo
Usuario.where(nombre: 'Ricardo')
# Todos los usuarios que el nombre sea DIFERENTE de Ricardo
Usuario.where.not(nombre: 'Ricardo')
que en sql sería
SELECT * FROM usuarios WHERE nombre = 'Ricardo';
SELECT * FROM usuarios WHERE nombre != 'Ricardo';

LIMIT & OFFSET
solo 8 usuarios sin orden especifico
Usuario.limit(8)
solo 5 usuarios sin orden especifico comenzando desde la fila 31
Usuario.limit(5).offset(30)
que en sql sería
SELECT * FROM usuarios LIMIT 8 ;
SELECT * FROM usuarios LIMIT 5 OFFSET 30;

GROUP & HAVING
#Trae la fecha de actualización y el promedio de la edad
#agrupados por día y donde el promedio sea mayor a 18
Usuario.select(date(updated_at) as ordered_date, avg(edad) as edad_avg").group("date(updated_at)").having("avg(edad) > ?", 18)


=end