//
//  ImagePicker.swift
//  Agenda
//
//  Created by Nutela on 26/02/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

enum MenuOpcoes {
    case camera
    case biblioteca
}

protocol ImagePickerFotoSelecionada {
    func imagemSelecionada(_ imagem : UIImage)
}

class ImagePicker: NSObject , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var delegate : ImagePickerFotoSelecionada?

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let foto = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagemSelecionada(foto)
        picker.dismiss(animated: true , completion: nil)
    }
    
    
    func menuOpcoes(completion: @escaping(_ opcao: MenuOpcoes) -> Void ) -> UIAlertController{
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Tirar Foto", style: .default) { (acao) in
            completion(.camera)
        }
        let biblioteca = UIAlertAction(title: "Escolher foto", style: .default) { (acao) in
            completion(.biblioteca)
        }
        let cancela = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(camera)
        menu.addAction(biblioteca)
        menu.addAction(cancela)
        return menu
    }
    
    
    
}
