//
//  AlunoViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import CoreData

class AlunoViewController: UIViewController, ImagePickerFotoSelecionada {
   
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viewImagemAluno: UIView!
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var buttonFoto: UIButton!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldSite: UITextField!
    @IBOutlet weak var textFieldNota: UITextField!
    
    let imagePicker = ImagePicker()
    
    var contexto: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arredondaView()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(_:)), name: .UIKeyboardWillShow, object: nil)
        self.setupView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func setupView(){
        imagePicker.delegate = self
    }
    // MARK: - Métodos
    
    func arredondaView() {
        self.viewImagemAluno.layer.cornerRadius = self.viewImagemAluno.frame.width / 2
        self.viewImagemAluno.layer.borderWidth = 1
        self.viewImagemAluno.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func aumentarScrollView(_ notification:Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + self.scrollViewPrincipal.frame.height/2)
    }
    
    // MARK: - IBActions
    func mostrarMultimida(_ opcao: MenuOpcoes){
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) && opcao == .camera {
            multimidia.sourceType = .camera
        }else{
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }
    
    
    @IBAction func buttonFoto(_ sender: UIButton) {
        
        
        let menu = ImagePicker().menuOpcoes { (opcao) in
            self.mostrarMultimida(opcao)
        }
        present(menu, animated: true, completion: nil)
       
        
    }
    
    @IBAction func stepperNota(_ sender: UIStepper) {
        self.textFieldNota.text = "\(sender.value)"
    }
    func imagemSelecionada(_ imagem: UIImage) {
        self.imageAluno.image = imagem
        buttonFoto.alpha = 0.05
    }
    
    @IBAction func salvarAluno(_ sender: UIButton) {
        let aluno = Aluno(context : contexto)
        aluno.endereco = textFieldEndereco.text
        aluno.nome = textFieldNome.text
        aluno.site = textFieldSite.text
        aluno.nota = (textFieldNota.text! as NSString).doubleValue
        aluno.telefone = textFieldTelefone.text
        aluno.imagem = imageAluno.image
        
        do {
            try contexto.save()
            navigationController?.popViewController(animated: true)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
}
