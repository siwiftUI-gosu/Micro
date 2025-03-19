import SwiftUI

struct AddBookCompleteView: View {
    
    var successCount: Int
    var failCount: Int
    var bookTitle: String
    @Environment(\.dismiss) var dismiss
    @State private var isAppeared = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 40) {
                Rectangle()
                    .frame(height: 0)
                    .opacity(isAppeared ? 1 : 0)
                    .offset(y: isAppeared ? 0 : 20)
                    .animation(.easeOut(duration: 0.5), value: isAppeared)
                
                AddBookCompleteViewLabel(
                    titleText: "\(successCount) 번",
                    descrptionText: "목표를 이루며 얻은 기쁨😆과"
                )
                .opacity(isAppeared ? 1 : 0)
                .offset(y: isAppeared ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(0), value: isAppeared)
                
                AddBookCompleteViewLabel(
                    titleText: "\(failCount) 번",
                    descrptionText: "목표에 도전🧗하며\n배운 소중한 나의 이야기를"
                )
                .opacity(isAppeared ? 1 : 0)
                .offset(y: isAppeared ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(1), value: isAppeared)
                
                AddBookCompleteViewLabel(
                    titleText: "\(bookTitle) 에",
                    descrptionText: "담았어요."
                )
                .opacity(isAppeared ? 1 : 0)
                .offset(y: isAppeared ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(2), value: isAppeared)
            }
            
            Spacer()
            
            Button(action: {
                // 홈 화면으로 돌아가기 코드
                dismiss()
            }) {
                Text("홈 화면으로 돌아가기")
                    .font(.system(size: 14, weight: .regular))
                    .underline()
                    .foregroundColor(.black)
                    .padding()
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, maxHeight: 42)
            .opacity(isAppeared ? 1 : 0)
            .offset(y: isAppeared ? 0 : 20)
            .animation(.easeOut(duration: 0.5).delay(3), value: isAppeared)
            
            Button(action: {
                dismiss()
            }) {
                Text("책 보러가기")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.button.backgroud.primary)
                    .cornerRadius(10)
            }
            .frame(maxWidth: .infinity, maxHeight: 52)
            .opacity(isAppeared ? 1 : 0)
            .offset(y: isAppeared ? 0 : 20)
            .animation(.easeOut(duration: 0.5).delay(3), value: isAppeared)

        }
        .padding(.horizontal, 16)
        .onAppear {
            isAppeared = true
        }
    }
}

struct AddBookCompleteViewLabel: View {
    
    var titleText: String
    var descrptionText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titleText)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color.primitive.green)
            Text(descrptionText)
                .font(.system(size: 18, weight: .regular))
                .lineSpacing(1.5)
        }
    }
}

//#Preview {
//    AddBookCompleteView(successCount: 10, failCount: 10, bookTitle: "temptemp", makeViewDismiss: .)
//}
