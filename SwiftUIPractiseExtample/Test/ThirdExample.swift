//
//  ThirdExample.swift
//  SwiftUIPractiseExtample
//
//  Created by Yumin Chu on 2023/05/09.
//

import SwiftUI

final class ThirdExampleVM {
    @State var isShow: Bool = false
}

struct ThirdExample: View {
    
    @State var isShow: Bool = false
    @State var routineButtonsStatus = Array(repeating: true, count: 6)
    enum RoutineType {
        case water
        case stretching
        case cardio
        case musule
        case drinking
        case smoking
        
        var title: String {
            switch self {
            case .water:
                return "물 마시기"
                
            case .stretching:
                return "스트레칭"
                
            case .cardio:
                return "유산소 운동"
                
            case .musule:
                return "근력 운동"
                
            case .drinking:
                return "금주하기"
                
            case .smoking:
                return "금연하기"
            }
        }
        
        var imageName: String {
            switch self {
            case .water:
                return "cup.and.saucer.fill"
                
            case .stretching:
                return "rectangle.fill"
                
            case .cardio:
                return "figure.walk"
                
            case .musule:
                return "flame.fill"
                
            case .drinking:
                return "drop.circle.fill"
                
            case .smoking:
                return "smoke.fill"
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            isShow ? Color.black.opacity(0.3).ignoresSafeArea() : Color.clear.ignoresSafeArea()
            
            VStack {
                Button("팝업 보이기", action: {
                    isShow = true
                })
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .background(Color("green_07D329"))
                .cornerRadius(10)
                
                Spacer()
            }
            
            if isShow {
                TransitionView(isShow: $isShow, routineButtonsStatus: $routineButtonsStatus)
                    .padding(.top, 30)
                    .padding(.bottom, 60)
                    .background(Color.white)
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                    .cornerRadius(20)
                    .transition(
                        .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom))
                    )
                    .animation(.spring())
                
                AlertView(isShow: $isShow, type: .water)

            }
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct RoutineView: View {
    
    let title: String
    let imageName: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("green_07D329"))
                .frame(width: 36, height: 36)
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxHeight: .infinity)
        }
        .frame(width: (UIScreen.main.bounds.width - 68) / 2 - 10, height: 76)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected ? Color("green_07D329")
                    : Color("lightgray_ D8D8D8"),
                    lineWidth: 2
                )
        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct TitleView: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        HStack {
            Text("나의 습관관리 편집")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Button(action: {
                isShow = false
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
}

struct ButtonsView: View {
    
    @Binding var routineButtonsStatus: [Bool]
    
    var body: some View {
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 20, alignment: .center),
            GridItem(.flexible(), spacing: 20, alignment: .center)
        ]
        
        return LazyVGrid(columns: columns, spacing: 10, content: {
            RoutineView(
                title: "물 마시기",
                imageName: "cup.and.saucer.fill",
                isSelected: $routineButtonsStatus[0]
            )
            RoutineView(
                title: "스트레칭",
                imageName: "rectangle.fill",
                isSelected: $routineButtonsStatus[1]
            )
            RoutineView(
                title: "유산소 운동",
                imageName: "figure.walk",
                isSelected: $routineButtonsStatus[2]
            )
            RoutineView(
                title: "근력 운동",
                imageName: "flame.fill",
                isSelected: $routineButtonsStatus[3]
            )
            RoutineView(
                title: "금주하기",
                imageName: "drop.circle.fill",
                isSelected: $routineButtonsStatus[4]
            )
            RoutineView(
                title: "금연하기",
                imageName: "smoke.fill",
                isSelected: $routineButtonsStatus[5]
            )
        })
        .padding(.horizontal, 40)
    }
}

struct SaveButtonView: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        Button("저장하기") {
            isShow = false
        }
        .foregroundColor(.white)
        .fontWeight(.medium)
        .frame(height: 64)
        .frame(maxWidth: UIScreen.main.bounds.width - 80)
        .background(Color("green_07D329"))
        .cornerRadius(20)
    }
}

struct TransitionView: View {
    
    @Binding var isShow: Bool
    @Binding var routineButtonsStatus: [Bool]
    @State var isAlertShow: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                TitleView(isShow: $isShow)
                Spacer()
                ButtonsView(routineButtonsStatus: $routineButtonsStatus)
                Spacer()
                SaveButtonView(isShow: $isShow)
            }
            
            ZStack {
                isAlertShow ? Color.black.opacity(0.3).ignoresSafeArea() : Color.clear.ignoresSafeArea()
                
//                if isAlertShow {
//                    AlertView(isShow: $isAlertShow)
//                        .background(Color.white)
//                        .frame(width: UIScreen.main.bounds.width - 40, height: 293)
//                        .cornerRadius(20)
//                }
            }
        }
    }
}

struct AlertView: View {
    
    @Binding var isShow: Bool
    let type: ThirdExample.RoutineType
    
    var body: some View {
        VStack(spacing: 40) {
            Text("안내")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.gray)
            
            VStack(spacing: 10) {
                Text("'\(type.title)'를 비활성화 할까요?")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color("black_2F2F2F"))
                
                Text("해제 시 관리화면에 해당 위젯이 사라집니다.")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color("gray_C7C7C7"))
            }
            
            HStack(spacing: 10) {
                Button("취소") {
                    
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: (UIScreen.main.bounds.width - 90) / 2, height: 64)
                .background(Color("gray_B0B0B0"))
                .cornerRadius(15)
                
                Button("확인") {
                    
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: (UIScreen.main.bounds.width - 90) / 2, height: 64)
                .background(Color("green_07D329"))
                .cornerRadius(15)
            }
        }
        .padding(.vertical, 20)
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ThirdExample_Previews: PreviewProvider {
    static var previews: some View {
        ThirdExample()
    }
}
