class SeedCustom

  def julian
    User.find_by(last_name: "Honma")
  end

  def create_divesites
    divesites.each do |d|
      divesite = Divesite.new(name: d[0], location: d[1])
      if divesite.save
        puts "Divesite created: " + d[0]
      else
        puts divesite.errors.full_messages
      end
    end
  end

  # def create_dives(user, number)
  #   dives.first(number).each_with_index do |dive, i|
  #     new_dive = user.dives.new(dive)
  #     if new_dive.save!
  #       begin
  #         new_dive.photo_urls = photos[i]
  #         puts "Dive created"
  #       rescue
  #         puts "Failure to connect to Cloudinary"
  #       end
  #     end
  #   end
  # end

  def photos
    [
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/bali-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/bali-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/bali-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/bos-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/bos-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/bos-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/boston-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/boston-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/boston-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/flo-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/flo-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/flo-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/gili-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/gili-dive-3.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/gili-dive-4.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/greece-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/greece-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/greece-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/lanta-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/lanta-dive-3.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/lanta-dive-4.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/mexico-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/mexico-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/mexico-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/mexico-sav-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/mexico-sav-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/mexico-sav-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/nahant-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/nahant-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/nahant-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/ray-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/ray-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/ray-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/seal-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/seal-dive-3.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/seal-dive-5.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/shark-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/shark-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/shark-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/whale-shark-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/whale-shark-dive-2.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/whale-shark-dive-3.jpg"],
      ["http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/wreck-dive-1.jpg", "http://res.cloudinary.com/jooleeanh/image/upload/v1480379642/my-dives/wreck-dive-2.jpg"],
    ]
  end

  def divesites
    [
      ["Jemeluk", "Bali, Thailand"],
      ["Cathedral Rock", "Cathedral Rocks, Cape Ann, MA"],
      ["Old Garden Beach", "Old Garden Beach, Cape Ann, MA"],
      ["Blue Heron Bridge", "Blue Heron Bridge, Florida"],
      ["Turtle Heaven", "Gili Air, Indonesia"],
      ["Blue Dome", "Paros, Greece"],
      ["Hin Muang", "Ko Lanta, Thailand"],
      ["Cenote Minotauro", "Playa del Carmen, Mexico"],
      ["Cenote Dreamgate", "Tulum, Mexico"],
      ["Canoe Beach", "Nahant, MA"],
      ["Stingray City", "Cayman Islands"],
      ["Isle of Shoals", "Boston, MA"],
      ["Jupiter", "Jupiter, Florida"],
      ["Isla Mujeres", "Isla Mujeres, Mexico"],
      ["Kittiwake", "Cayman Islands"]
    ]
  end

  def dives
    [
      {
        divesite: Divesite.find_by(name: "Jemeluk"),
        datetime: Time.now - rand(10...350).day,
        types: "Wall",
        tank_size: 15,
        bottom_time: 63,
        start_air: to_bar(2956),
        end_air: to_bar(473),
        max_depth: to_m(88.7),
        max_temp: 18,
        comments: "Clown fish was cleaning itself in anemone, funny. Two longer transparent shrimps. Almost saw too much, kind of wished it was spread over several dives. I guess next time I'll take more time and focus on one thing. ",
        enjoyment: 4,
        visibility: 25,
        # photo_urls: ["dive-photos/bali-dive-1.jpg", "dive-photos/bali-dive-2.jpg", "dive-photos/bali-dive-3.jpg", "dive-photos/bali-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Cathedral Rock"),
        datetime: Time.now - rand(10...350).day,
        types: "Shore",
        tank_size: 12,
        bottom_time: 48,
        start_air: to_bar(2982),
        end_air: to_bar(467),
        max_depth: to_m(75.3),
        max_temp: 12,
        comments: "Pretty intense. Lot of air in drysuit, wasting because of bad buoyancy.	Was looking okay, but was just going up and down. Feet were still raising a bit. Generally too much air in suit. Headed out 60d for some 50m, and continued in that heading for the entire dive. 	Same old same old.		Everyone acted pretty well. Max told me that I was kicking too fast, and needed to give clearer instructions before people got in the water (people waited). I was still stressed. Went through my air pretty fast. Max took my reg at 75 feet which was interesting because I actually never had taken my octo from the shoulder position. Glad it worked.",
        enjoyment: 3,
        visibility: 10,
        # photo_urls: ["dive-photos/bos-dive-1.jpg", "dive-photos/bos-dive-2.jpg", "dive-photos/bos-dive-3.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Old Garden Beach"),
        datetime: Time.now - rand(10...350).day,
        types: "Shore",
        tank_size: 12,
        bottom_time: 67,
        start_air: to_bar(3000),
        end_air: to_bar(1850),
        max_depth: to_m(20),
        max_temp: 14,
        comments: "Tried to show Seve the cool small stuff, he headed back early to work at the shop. Dave and I had a blast after, just looking at really cool macro stuff. Suit felt much more compressed, probably because of shoulder straps.",
        enjoyment: 4,
        visibility: 15,
        # photo_urls: ["dive-photos/boston-dive-1.jpg", "dive-photos/boston-dive-2.jpg", "dive-photos/boston-dive-3.jpg", "dive-photos/boston-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Blue Heron Bridge"),
        datetime: Time.now - rand(10...350).day,
        types: "Night",
        tank_size: 12,
        bottom_time: 65,
        start_air: to_bar(3327),
        end_air: to_bar(1962),
        max_depth: to_m(19),
        max_temp: 22,
        comments: "Entered 30 min before high tide (current still strong), swam to bridge, saw cool stuff on north side, went south under the bridge, Nathalie got lost and we went further south, went back to north side and came out.	2 octopii, armor shrimp",
        enjoyment: 5,
        visibility: 15,
        # photo_urls: ["dive-photos/flo-dive-1.jpg", "dive-photos/flo-dive-2.jpg", "dive-photos/flo-dive-3.jpg", "dive-photos/flo-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Turtle Heaven"),
        datetime: Time.now - rand(10...350).day,
        types: "Boat",
        tank_size: 12,
        bottom_time: 69,
        start_air: 213,
        end_air: 73,
        max_depth: 17.4,
        max_temp: 31,
        comments: "5-7 turtles, fish that pops up and down :P Really cool landing pad for turtles. Had the pinnacle with the 5-6 turtles all for ourselves for some good 10 minutes and it was sweet.",
        enjoyment: 5,
        visibility: 30,
        # photo_urls: ["dive-photos/gili-dive-1.jpg", "dive-photos/gili-dive-3.jpg", "dive-photos/gili-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Blue Dome"),
        datetime: Time.now - rand(10...350).day,
        types: "Boat",
        tank_size: 12,
        bottom_time: 39+8,
        start_air: to_bar(2826),
        end_air: to_bar(1205),
        max_depth: to_m(51),
        max_temp: 26,
        comments: "2 octopii, some fish, nothing much. Katerina kind of pressured Sophie into not going. One of the tank was leaking from the handle. We were supposed not to go past 18m, which didn't happen. The blue dome was really neat. I love everytime I enter a swim through for the first time, it gives this sweet chill. We could feel the pressure change with the waves in the air pocket, which smelled a bit moldy.",
        enjoyment: 3,
        visibility: 25,
        # photo_urls: ["dive-photos/greece-dive-1.jpg", "dive-photos/greece-dive-2.jpg", "dive-photos/greece-dive-3.jpg", "dive-photos/greece-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Hin Muang"),
        datetime: Time.now - rand(10...350).day,
        types: "Boat",
        tank_size: 12,
        bottom_time: 59,
        start_air: 189,
        end_air: 41,
        max_depth: 25.9,
        max_temp: 29,
        comments: "Morray eels, big blue+black starfish destroyers. Not much light, color and visibility. Small current that always made us swim. Didn't see anything, particular.",
        enjoyment: 4,
        visibility: 15,
        # photo_urls: ["dive-photos/lanta-dive-1.jpg", "dive-photos/lanta-dive-3.jpg", "dive-photos/lanta-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Cenote Minotauro"),
        datetime: Time.now - rand(10...350).day,
        types: "Cave",
        tank_size: 12,
        bottom_time: 96,
        start_air: to_bar(3100),
        end_air: to_bar(1400),
        max_depth: to_m(52),
        max_temp: 22,
        comments: "Took the left line of the cavern line until we reached the danger sign at the back of the cavern. Secret jump hard left, passing to the left of the sign. We stayed on the cave lime until it ends. We came up one Cenote on the way back and went back on the wrong line, which was fortunately not dangerous since we knew the cave. Really cool light effects on the halocline. ",
        enjoyment: 5,
        visibility: 30,
        # photo_urls: ["dive-photos/mexico-dive-1.jpg", "dive-photos/mexico-dive-2.jpg", "dive-photos/mexico-dive-3.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Cenote Dreamgate"),
        datetime: Time.now - rand(10...350).day,
        types: "Cave",
        tank_size: 12,
        bottom_time: 63,
        start_air: to_bar(3100),
        end_air: to_bar(1300),
        max_depth: to_m(50),
        max_temp: 24,
        comments: "Took the right (shorter) line, jumped right after the sign and secret jump left at the anvil shape rock. Got to the Chinese Garden and further into the restrictions. Went back same way.",
        enjoyment: 5,
        visibility: 30,
        # photo_urls: ["dive-photos/mexico-sav-dive-1.jpg", "dive-photos/mexico-sav-dive-2.jpg", "dive-photos/mexico-sav-dive-3.jpg", "dive-photos/mexico-sav-dive-4.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Canoe Beach"),
        datetime: Time.now - rand(10...350).day,
        types: "Shore",
        tank_size: 12,
        bottom_time: 48,
        start_air: to_bar(3250),
        end_air: to_bar(1500),
        max_depth: to_m(29),
        max_temp: 8,
        comments: "Followed Mack to valley, played around, separated, went along wall looking for swim throughs, didn't find many, but cool caves. Following and hanging out with the others was a bit nonsensical but Dave and I had more fun when we separated.",
        enjoyment: 3,
        visibility: 10,
        # photo_urls: ["dive-photos/nahant-dive-1.jpg", "dive-photos/nahant-dive-2.jpg", "dive-photos/nahant-dive-3.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Stingray City"),
        datetime: Time.now - rand(10...350).day,
        types: "Boat",
        tank_size: 12,
        bottom_time: 26,
        start_air: 185,
        end_air: 74,
        max_depth: rand(10..22),
        max_temp: 26,
        comments: "Awesome dive with stingrays!",
        enjoyment: 5,
        visibility: 20,
        # photo_urls: ["dive-photos/ray-dive-1.jpg", "dive-photos/ray-dive-2.jpg", "dive-photos/ray-dive-3.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Isle of Shoals"),
        datetime: Time.now - rand(10...350).day,
        types: "Seal",
        tank_size: 12,
        bottom_time: rand(40..72),
        start_air: [190,200,207].sample,
        end_air: [20,35,40,50,70,90].sample,
        max_depth: rand(10...22),
        max_temp: 26,
        comments: "2 playful seals! 1 small female that interacted a lot, and one curious big male. Top 5 best dive. Lots of fun with the female!",
        enjoyment: 5,
        visibility: 15,
        # photo_urls: ["dive-photos/seal-dive-1.jpg", "dive-photos/seal-dive-3.jpg", "dive-photos/seal-dive-5.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Jupiter"),
        datetime: Time.now - rand(10...350).day,
        types: "Shark",
        tank_size: 12,
        bottom_time: rand(40..72),
        start_air: [190,200,207].sample,
        end_air: [20,35,40,50,70,90].sample,
        max_depth: rand(10...22),
        max_temp: 26,
        comments: "Descended a bit late (me being slow and Nathalie having ear issues), got separated and I suggested going back up. Nathalie insisted we stay down, so we stayed at 90-100 ft, saw a shark at a distance, and then found the group. Seeing the sharks up close was nice. They weren't scary at all.",
        enjoyment: 4,
        visibility: 20,
        # photo_urls: ["dive-photos/shark-dive-1.jpg", "dive-photos/shark-dive-2.jpg", "dive-photos/shark-dive-3.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Isla Mujeres"),
        datetime: Time.now - rand(10...350).day,
        types: "Boat",
        tank_size: 12,
        bottom_time: rand(40..72),
        start_air: [190,200,207].sample,
        end_air: [20,35,40,50,70,90].sample,
        max_depth: rand(10...22),
        max_temp: 26,
        comments: "Huge whale sharks, was really hard to follow along, they swim really fast!",
        enjoyment: 2,
        visibility: 15,
        # photo_urls: ["dive-photos/whale-shark-dive-1.jpg", "dive-photos/whale-shark-dive-2.jpg", "dive-photos/whale-shark-dive-3.jpg"]
      },
      {
        divesite: Divesite.find_by(name: "Kittiwake"),
        datetime: Time.now - rand(10...350).day,
        types: "Wreck",
        tank_size: 12,
        bottom_time: rand(40..72),
        start_air: [190,200,207].sample,
        end_air: [20,35,40,50,70,90].sample,
        max_depth: rand(10...22),
        max_temp: 26,
        comments: "Really cool wreck with not too much wild life but spacious passages to swim through.",
        enjoyment: 3,
        visibility: 30,
        # photo_urls: ["dive-photos/wreck-dive-1.jpg", "dive-photos/wreck-dive-2.jpg"]
      }
    ]
  end

  def to_bar(psi)
    (psi * 0.0689).round
  end

  def to_m(feet)
    (feet * 0.3048).round(1)
  end
end
