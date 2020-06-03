//
//  AstronautView.swift
//  Moonshot
//
//  Created by алтынпончик on 5/26/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions:").font(.headline).padding(.horizontal)
                    
                    ForEach(self.missions) { mission in // challenge 2 day 42
                        HStack {
                            Image("\(mission.image)")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width * 0.1)
                            Text("\(mission.displayName)")
                        }.padding(.horizontal)
                            .accessibilityElement(children: .combine)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in allMissions {
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}) {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: mission)
    }
}
