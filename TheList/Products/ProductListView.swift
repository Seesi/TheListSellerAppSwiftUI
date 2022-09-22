//
//  ProductListView.swift
//  TheList
//
//  Created by Daniel Adoboah-Seesi on 21/09/2022.
//

import SwiftUI

struct ProductListView: View {
	@Environment(\.dismiss) var dismiss
	@FetchRequest(
		sortDescriptors: [],
		animation: .default)
	var productEntitites: FetchedResults<ProductData>
	@StateObject private var vm = ViewModel()
    var body: some View {
		 VStack{
			 ZStack (alignment: .center){
				 Text("Add Products to Reel")
					 .foregroundColor(.black)
					 .font(.system(size: 16))
					 .fontWeight(.bold)
				 HStack{
					 Spacer()
					 Button(action: {
						 dismiss()
					 },label: {
						 Image("close-black")
					 })
					 .background(.clear)
					 .padding([.trailing])
				 }
			 }.padding()
			 
			 List(vm.products, id: \.id){ item in
				 VStack(alignment: .leading){
					 HStack{
						 AsyncImage(url: URL(string: item.imageUrl)) { image in
							 image
								 .resizable()
								 .aspectRatio(contentMode: .fit)
								 .background(.clear)
						 } placeholder: {
							 ProgressView()
						 }
						 .frame(width: 70, height: 70)
						 .background(Color(UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.03)))
						 .padding()
						 VStack(alignment:.leading){
							 Text(item.designer)
								 .font(.system(size: 14))
								 .fontWeight(.bold)
							 Text(item.title)
								 .font(.system(size: 12))
						 }
						 Spacer()
						 CheckBoxButton(checked: $vm.products.first(where: {product in
							 return product.id == item.id
						 })!.selected)
					 }
				 }
			 }
			 .task {
				 await vm.getProducts()				 
			 }
		 }.background(.white)
		 
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}