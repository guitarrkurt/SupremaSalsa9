//
//  ComprasViewController.swift
//  Suprema Salsa
//
//  Created by guitarrkurt on 08/11/15.
//  Copyright © 2015 miguel mexicano. All rights reserved.
//

import UIKit

class ComprasViewController: UIViewController, UICollectionViewDataSource {
    var arrayCarta = ["aguaHorchata.png", "aguaJamaica.png", "arabeKilo.png", "burrito.png", "Chistorra.png", "cincoTacosPastor.png", "cochinita2.png", "cebollitas.png", "chalupas.png", "taco arabe.png", "costillas.png", "tacobistec.png", "aguasimple.png", "arrachera.png", "sincronizada.png", "frijoles.png", "gringa.png", "carnepastormenu.png", "sirlon.png", "unTacoPastor.png"]
    
    @IBOutlet weak var sera: UIImageView!
    //var arrayCarrito            : NSMutableArray           = NSMutableArray()
    var arrayCarrito = ["cheese_icon_white.png", "drink_white.png", "favorite_icon_white.png", "cheese_icon_white.png", "drink_white.png", "favorite_icon_white.png"]
    
    @IBOutlet weak var cartaCollectionView: UICollectionView!
    @IBOutlet weak var carritoCollectionView: UICollectionView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        /*Diseno*/
        //Esta linea de codigo se pone porque xcode mueve nuestro UICollectionViewCell
        self.automaticallyAdjustsScrollViewInsets = false
        //Transparencia de carrito collection view
        
        carritoCollectionView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
            //UIColor(patternImage: UIImage(named: "carbon2.jpg")!)
        //sera.image = UIImage(named: "cedro.jpg")
        
        cartaCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "launch_screen_ipad_1536x2048.jpg")!)
        
        /*Actiones*/
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "SwipeGestureRecognized:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        carritoCollectionView.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "SwipeGestureRecognized:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        carritoCollectionView.addGestureRecognizer(swipeUp)
    }
    func SwipeGestureRecognized(gestureRecognizer: UIGestureRecognizer){
        let swipePress = gestureRecognizer as! UISwipeGestureRecognizer
        let locationInView = swipePress.locationInView(carritoCollectionView)
        let indexPath = carritoCollectionView.indexPathForItemAtPoint(locationInView)
        if indexPath != nil{
            arrayCarrito.removeAtIndex((indexPath?.item)!)
            carritoCollectionView.reloadData()
        }

    }
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if(collectionView == self.cartaCollectionView){
            return arrayCarta.count
        }
        if(collectionView == self.carritoCollectionView){
            return arrayCarrito.count
        }
        return 0
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{

        if(collectionView == cartaCollectionView){
            let CellCarta = collectionView.dequeueReusableCellWithReuseIdentifier("CellCarta", forIndexPath: indexPath) as! CartaCollectionViewCell
            CellCarta.button.setBackgroundImage(UIImage(named: arrayCarta[indexPath.item]), forState: .Normal)
            return CellCarta
        }
        if(collectionView == carritoCollectionView){
            let CellCarrito = collectionView.dequeueReusableCellWithReuseIdentifier("CellCarrito", forIndexPath: indexPath) as! CarritoCollectionViewCell
            CellCarrito.producto.image = UIImage(named: arrayCarrito[indexPath.item])
            return CellCarrito
        }
        //Fucking Swift
        return UICollectionViewCell()
    }
    //Que las celdas ocupen la mitad de la pantalla
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if(collectionView == cartaCollectionView){
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            return CGSize(width: screenSize.width/2, height: screenSize.width/2);
        }else{
            let algo = self.carritoCollectionView.bounds
            
            return CGSize(width: algo.height-30.0, height: algo.height-30.0)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
