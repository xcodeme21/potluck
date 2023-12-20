import SwiftUI

struct EventView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(0..<5) { _ in
                            CardView()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Events")
        }
    }
}

struct CardView: View {
    @State private var isToDetailEvent = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Image on the left
            AsyncImage(url: URL(string: "https://foto.kontan.co.id/FPN05GIgN3RC-9HZEY2Ny-OLEYU=/smart/2021/02/11/1574363234p.jpg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 130)
                    .clipShape(RoundedCorner(corner: [.topLeft, .bottomLeft], radius: 10))
                    .padding(.top, -40)
                    .padding(.bottom, -40)
            } placeholder: {
                // Placeholder view saat gambar sedang dimuat
                ProgressView()
            }
            
            // Details on the right
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Potluck Ibox")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .textCase(.uppercase)
                
                Text("Ended")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .clipShape(RoundedCorner(corner: [.topLeft, .bottomRight], radius: 10))
                    .padding(.bottom, 10)
                
                
                HStack {
                    Text("Quota: 500")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("20 Jan 2024")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                
                NavigationLink(destination: DetailEventView(), isActive: $isToDetailEvent) {
                    HStack {
                        Text("Detail")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.bottom, 10)
    }
}
