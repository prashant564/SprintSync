//
//  EditScrumSheet.swift
//  Scrumdinger
//
//  Created by PrashantDixit on 15/06/23.
//

import SwiftUI

struct EditScrumSheet: View {
    @Binding var scrum: DailyScrum
    @Binding var isPresentingEditView: Bool
    @Binding var scrumToEdit: DailyScrum

    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $scrumToEdit)
                .navigationTitle($scrumToEdit.title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingEditView = false
                            scrum = scrumToEdit
                        }
                    }
                }
        }
    }
}

struct EditScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditScrumSheet(scrum: .constant(DailyScrum.sampleData[0]), isPresentingEditView: .constant(true), scrumToEdit: .constant(DailyScrum.sampleData[0]))
    }
}
