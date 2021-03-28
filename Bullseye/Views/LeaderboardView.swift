//
//  LeaderboardView.swift
//  Bullseye
//
//  Created by Manuel Martinez Gomez on 28/3/21.
//

import SwiftUI

struct LeaderboardView: View {
  @Binding var leaderboardIsShowing: Bool
  @Binding var game: Game
  
  var body: some View {
    ZStack {
      Color("BackgroundColor").edgesIgnoringSafeArea(.all)
      ScrollView {
        VStack(spacing: 10) {
          HeaderView(leaderboardIsShowing: $leaderboardIsShowing)
          LabelView()
          VStack(spacing: 10) {
            ForEach(game.leaderboardEntries.indices) { index in
              let leaderboardEntry = game.leaderboardEntries[index]
              RowView(index: index,
                      score: leaderboardEntry.score,
                      date: leaderboardEntry.date)
            }
          }
        }
      }
    }
  }
}

struct RowView: View {
  let index: Int
  let score: Int
  let date: Date
  
  var body: some View {
    HStack{
      RoundedTextView(text: String(index))
      Spacer()
      ScoreText(score: score)
        .frame(width: Constants.LeaderBoard.leaderBoardScoreColWidth)
      Spacer()
      DateText(date: date)
        .frame(width: Constants.LeaderBoard.leaderBoardDateColWidth)
    }
    .background(
      RoundedRectangle(cornerRadius: .infinity)
        .strokeBorder(Color("LeaderboardRowColor"),
                      lineWidth: Constants.General.strokeWidth)
    )
    .padding(.leading)
    .padding(.trailing)
    .frame(maxWidth: Constants.LeaderBoard.leaderBoardMaxColWidth)
  }
}

struct HeaderView: View {
  @Binding var leaderboardIsShowing: Bool
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  
  var body: some View {
    ZStack {
      HStack {
        if verticalSizeClass == .regular && horizontalSizeClass == .compact {
          BigBoldText(text: "Leaderboard")
            .padding(.leading)
          Spacer()
        } else {
          BigBoldText(text: "Leaderboard")
        }
      }
      .padding(.top)
      HStack {
        Spacer()
        Button(action: {
          leaderboardIsShowing = false
        }, label: {
          RoundedImageViewFilled(systemName: "xmark")
            .padding(.trailing)
        })
      }
    }
  }
}

struct LabelView: View {
  var body: some View {
    HStack {
      Spacer()
        .frame(width: Constants.General.roundedViewLength)
      Spacer()
      LabelText(text: "Score")
        .frame(width: Constants.LeaderBoard.leaderBoardScoreColWidth)
      Spacer()
      LabelText(text: "Date")
        .frame(width: Constants.LeaderBoard.leaderBoardDateColWidth)
    }
    .padding(.leading)
    .padding(.trailing)
    .frame(maxWidth: Constants.LeaderBoard.leaderBoardMaxColWidth)
  }
}

struct LeaderboardView_Previews: PreviewProvider {
  static private var leaderboardIsShowing = Binding.constant(false)
  static private  var game = Binding.constant(Game(loadTestData: true))
  
  static var previews: some View {
    LeaderboardView(leaderboardIsShowing: leaderboardIsShowing,
                    game: game)
    LeaderboardView(leaderboardIsShowing: leaderboardIsShowing,
                    game: game).previewLayout(.fixed(width: 568, height: 320))
    LeaderboardView(leaderboardIsShowing: leaderboardIsShowing,
                    game: game)
      .preferredColorScheme(.dark)
    LeaderboardView(leaderboardIsShowing: leaderboardIsShowing,
                    game: game)
      .previewLayout(.fixed(width: 568, height: 320))
      .preferredColorScheme(.dark)
  }
}
