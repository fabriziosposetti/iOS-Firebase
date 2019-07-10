//
//  StringHelper.swift
//  intercorpApp
//
//  Created by Fabrizio Sposetti on 05/07/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import Foundation

protocol LocalizedEnum: CustomStringConvertible {}

class BundleMarker {}

extension LocalizedEnum where Self: RawRepresentable, Self.RawValue == String {
    var description: String {
        let tableName = "Strings"
        let bundle =  Bundle(for: BundleMarker.self)
        return NSLocalizedString(self.rawValue,
                                 tableName: tableName,
                                 bundle: bundle,
                                 value: "",
                                 comment: "")
    }
}

enum Textos: String, LocalizedEnum {
    
    case CamposVacios
    case CreacionCliente
    case UsuarioGuardadoCorrectamente
    case ErrorAlGuardarUsuario
    case Enviar
    case Nombre
    case Apellido
    case FechaNacimiento
    case Edad
    case Login
}

