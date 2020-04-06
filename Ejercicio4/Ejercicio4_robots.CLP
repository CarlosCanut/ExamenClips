(deffacts datos
	(robot box 1 paquetes 0 destinos 0)
	(box 1 paquetes 0 destino 0)
	(box 2 paquetes 2 destino 1)
	(box 3 paquetes 8 destino 4)
	(box 4 paquetes 4 destino 3)
	(box 5 paquetes 0 destino 0)
)

(defrule moverseDerecha
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin)
	(test (< ?box 5))
	=>
	(assert (robot box (+ ?box 1) paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin))
	(retract ?f)
)

(defrule moverseIzquierda
	(declare (salience 25))
	?f <- (robot box ?box paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin)
	(test (= ?box 5))
	=>
	(assert (robot box (- ?box 1) paquetes $?p_ini ?p $?p_fin destinos $?d_ini ?d $?d_fin))
	(retract ?f)
)
