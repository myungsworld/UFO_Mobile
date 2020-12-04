import SwiftUI
import Combine

struct ProfileView : View {
    
    @EnvironmentObject var profileTask : ProfileTask
    
    var body : some View {
        NavigationView{
            VStack{
                NavigationLink(destination: ChargeRecordView()){
                    Text("충전 내역")
                }
                NavigationLink(destination: PayRecordView()){
                    Text("결제 내역")
                }
                NavigationLink(destination: PasswordChangeView()){
                    Text("비밀 번호 변경")
                }
            }
        }
        //        List(chargeRecord){ item in
//            HStack{
//                Text(item.time)
//                Text(item.amountMoney)
//            }
            
                
        }
    }



