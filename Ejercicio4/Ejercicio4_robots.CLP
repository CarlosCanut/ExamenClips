(deffacts datos
	(robot box 1 paquetes 0 destinos 0 direccion 0)
	(box 1 paquetes 0 destino 0)
	(box 2 paquetes 2 destino 1)
	(box 3 paquetes 8 destino 4)
	(box 4 paquetes 4 destino 3)
	(box 5 paquetes 0 destino 0)
)

(defrule recogerPaquete
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	?b <- (box ?box paquetes ?paquete_box destino ?destino_paquete)
	(test (< ?p 8))
	=>
	(retract ?f)
	(assert (robot box ?box paquetes $?p_ini (+ ?p ?paquete_box) $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion) )
	(retract ?b)
	(assert (box ?box paquetes 0 destino 0))
	
)

(defrule moverseDerecha
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	(test (= ?direccion 0))
	=>
	(assert (robot box (+ ?box 1) paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion))
	(retract ?f)
)

(defrule moverseIzquierda
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	(test (= ?direccion 1))
	=>
	(assert (robot box (- ?box 1) paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion))
	(retract ?f)
)

(defrule cambioDireccionDerecha
	(declare (salience 50))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	(test (= ?direccion 0))
	(test (= ?box 5))
	=> 
	(assert (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion (+ ?direccion 1)))
	(retract ?f)
)

(defrule cambioDireccionIzquierda
	(declare (salience 50))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	(test (= ?direccion 1))
	(test (= ?box 1))
	=> 
	(assert (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion (- ?direccion 1)))
	(retract ?f)
)