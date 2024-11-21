//
//  KakaoMapsView.swift
//  babya
//
//  Created by hyk on 11/21/24.
//

import SwiftUI
import KakaoMapsSDK
import KakaoMapsSDK_SPM

struct KakaoMapsView: UIViewRepresentable {
    @Binding var draw: Bool
        
        func makeUIView(context: Self.Context) -> KMViewContainer {
            let view: KMViewContainer = KMViewContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

            context.coordinator.createController(view)
            
            return view
        }

        func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
            if draw {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if context.coordinator.controller?.isEnginePrepared == false {
                        context.coordinator.controller?.prepareEngine()
                    }
                    
                    if context.coordinator.controller?.isEngineActive == false {
                        context.coordinator.controller?.activateEngine()
                    }
                }
            }
            else {
                context.coordinator.controller?.pauseEngine()
                context.coordinator.controller?.resetEngine()
            }
        }
        
        func makeCoordinator() -> KakaoMapCoordinator {
            return KakaoMapCoordinator()
        }

        static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
            
        }
        
        
        class KakaoMapCoordinator: NSObject, MapControllerDelegate {
            var longitude = 126.9223682
            var latitude = 37.5602871
            
            override init() {
                first = true
                auth = false
                super.init()
            }
            
            func createController(_ view: KMViewContainer) {
                container = view
                controller = KMController(viewContainer: view)
                controller?.delegate = self
            }
            
            func addViews() {
                let defaultPosition: MapPoint = MapPoint(longitude: longitude, latitude: latitude)
                let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
                
                controller?.addView(mapviewInfo)
            }
            
            func addViewSucceeded(_ viewName: String, viewInfoName: String) {
                print("OK")
                let view = controller?.getView("mapview")
                view?.viewRect = container!.bounds
            }
            
            func containerDidResized(_ size: CGSize) {
                let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
                mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
                if first {
                    let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: longitude, latitude: latitude), mapView: mapView!)
                    mapView?.moveCamera(cameraUpdate)
                    first = false
                }
            }
            
            func authenticationSucceeded() {
                auth = true
            }
            
            var controller: KMController?
            var container: KMViewContainer?
            var first: Bool
            var auth: Bool
        }
    }
