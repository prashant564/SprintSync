//
//  ScrumDetailEditView.swift
//  Scrumdinger
//
//  Created by PrashantDixit on 12/06/23.
//
import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""


    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesInDouble, in: 5...30, step: 5) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Atendees")){
                ForEach(scrum.attendees) {
                    attendee in
                    Text(attendee.name)
                }
                .onDelete {
                    indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                                let attendee = DailyScrum.Attendee(name: newAttendeeName)
                                scrum.attendees.append(attendee)
                                newAttendeeName = ""
                       }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
