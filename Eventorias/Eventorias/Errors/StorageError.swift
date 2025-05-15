//
//  ImageUploadError.swift
//  Eventorias
//
//  Created by Bruno Evrard on 22/04/2025.
//


enum StorageError: Error {
    case imageConversionFailed
    case uploadFailed(Error)
    case deleteFailed(Error)
    case urlRetrievalFailed(Error?)
    case invalidURL
}
