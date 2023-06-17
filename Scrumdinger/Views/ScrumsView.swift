//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by PrashantDixit on 10/06/23.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction:() -> Void
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)

                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .toolbar {
                    Button(action: { isPresentingNewScrumView = true }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
            }
            .navigationTitle("Daily Scrums")
            }
            .sheet(isPresented: $isPresentingNewScrumView){
                NewScrumSheet(isPresentingNewScrumView: $isPresentingNewScrumView, scrums: $scrums)
            }
            .onChange(of: scenePhase) { phase in
                if(phase == .inactive){
                    saveAction()
                }
            }
        }
    }


struct ScrumsView_Previews: PreviewProvider {
    static var scrums: [DailyScrum] = DailyScrum.sampleData
    static var previews: some View {
        ScrumsView(scrums: .constant(scrums), saveAction: {})
    }
}
