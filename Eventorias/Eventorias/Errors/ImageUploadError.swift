//
//  ImageUploadError.swift
//  Eventorias
//
//  Created by Bruno Evrard on 22/04/2025.
//


enum ImageUploadError: Error {
    case imageConversionFailed
    case uploadFailed(Error)
    case urlRetrievalFailed(Error?)
}