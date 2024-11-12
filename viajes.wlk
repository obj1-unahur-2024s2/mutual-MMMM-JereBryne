
class Viajes {
  const property idiomas

  method esInteresante() = idiomas.size() > 1
  method sirveParaBroncearse()
  method esRecomendadaPara(unSocio) =
    self.esInteresante() and
    unSocio.atraeAlSocio(self) and
    not unSocio.yaRealizo(self)
}

class ViajesDePlaya inherits Viajes {
  const largoDePlaya
  
  method diasDuracion() = largoDePlaya/500
  method implicaEsfuerzo() = largoDePlaya > 1200
  override method sirveParaBroncearse() = true
}

class ExcursionACiudad inherits Viajes {
  const cantidadAtracciones
   
  method diasDuracion() = cantidadAtracciones/2
  method implicaEsfuerzo() = cantidadAtracciones.between(5, 8)
  override method sirveParaBroncearse() = false

  override method esInteresante() = super() or cantidadAtracciones == 5
}

class ExcursionACiudadTropical inherits ExcursionACiudad {
  override method diasDuracion() = super() + 1
  override method sirveParaBroncearse() = true
}

class SalidaDeTrekking inherits Viajes {
  const kmDeSenderos
  const diasDeSol

  method diasDuracion() = kmDeSenderos /50
  method implicaEsfuerzo() = kmDeSenderos > 80
  override method sirveParaBroncearse() = 
    diasDeSol > 200 or
    (diasDeSol.between(100, 200) and kmDeSenderos > 120 )
  override method esInteresante() = super() and diasDeSol > 140
}

class ClasesDeGimnasia {
  const property idiomas = ["español"]
  method diasDuracion() = 1
  method implicaEsfuerzo() = true
  method sirveParaBroncearse() = false

  method esRecomendadaPara(unSocio) = unSocio.edad().between(20, 30)
}

class Socio {
  const actividadesRealizadas = []
  const maximoDeActividades
  const property edad 
  const idiomas

  method esAdoradorDelSol() = 
    actividadesRealizadas.all{a=>a.sirveParaBroncearse()}
  method actividadesEsforzadas() = 
    actividadesRealizadas.filter({a=>a.implicaEsfuerzo()}).asSet()
  method realizarActividad(unaActividad) {
    if (actividadesRealizadas.size()<maximoDeActividades){
      actividadesRealizadas.add(unaActividad)
    } else {
      self.error("No puede realizar mas actividades")
    }
  }
  method atraeAlSocio(unaActividad)
  method yaRealizo(unaActividad) = actividadesRealizadas.contains(unaActividad)
  method cantIdiomas() = idiomas.size()
}

class SocioTranquilo inherits Socio {
  override method atraeAlSocio(unaActividad) = unaActividad.diasDuracion()>=4
}

class SocioCoherente inherits Socio {
  override method atraeAlSocio(unaActividad) {
    if (self.esAdoradorDelSol()){
      return unaActividad.sirveParaBroncearse()
    } else {
      return unaActividad.implicaEsfuerzo()
    }
  }
}
class SocioRelajado inherits Socio {
  override method atraeAlSocio(unaActividad)=
    idiomas.any({i=>unaActividad.idiomas().contains(i)})
}

class TallerLiterario {
  const libros 

  method idiomas() = libros.map({l=>l.idioma()})
  method diasDuracion() = libros.size() +1
  method implicaEsfuerzo() =
    libros.any({l=>l.cantPaginas() > 500}) or
    (libros.size()>1 and libros.all({l=>l.autor() == l.first().autor()}))
  method sirveParaBroncearse() = false
  method esRecomendadaPara(unSocio) = unSocio.cantIdiomas() > 1
}

class Libro {
  const property idioma
  const property cantPaginas
  const property autor
}