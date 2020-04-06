(deffacts datos
	(robot box 1 paquetes 0 destinos 0 direccion 0)
	(entregas 0 objetivo 3)
	(box 1 paquetes 0 destino 0)
	(box 2 paquetes 2 destino 1)
	(box 3 paquetes 8 destino 4)
	(box 4 paquetes 4 destino 3)
	(box 5 paquetes 0 destino 0)
)

(defrule fin
	(declare (salience 100))
	?f <- (entregas ?x objetivo ?y)
	(test (= ?x ?y))
	=>
	(halt)
)

(defrule recogerPaquete
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	?b <- (box ?box paquetes ?paquete_box destino ?destino_paquete)
	(test (< ?p 9))
	(test (> ?paquete_box 0))
	(test (= ?d 0))
	=>
	(retract ?f)
	(assert (robot box ?box paquetes $?p_ini (+ ?p ?paquete_box) $?p_fin destinos $?d_ini (+ ?d ?destino_paquete) $?d_fin direccion ?direccion) )
	(retract ?b)
	(assert (box ?box paquetes 0 destino 0))
)

(defrule entregarPaquete
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin direccion ?direccion)
	?e <- (entregas ?entregas objetivo ?objetivo)
	(test (> ?p 0))
	(test (<> ?d 0))
	(test (= ?d ?box))
	=>
	(retract ?f)
	(assert (robot box ?box paquetes $?p_ini (- ?p ?p) $?p_fin destinos $?d_ini (- ?d ?d) $?d_fin direccion ?direccion) )
	(retract ?e)
	(assert (entregas (+ ?entregas 1) objetivo ?objetivo))
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