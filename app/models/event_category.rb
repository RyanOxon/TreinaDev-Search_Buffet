class EventCategory < ApplicationRecord
  belongs_to :event

  enum category: {debutante_ball: 0, wedding: 1, conferences: 2, congresses: 3,
                  corporate: 4, birthday: 5, baby_shower: 6, gaduations: 7, 
                  inaugurations: 8 }
end
