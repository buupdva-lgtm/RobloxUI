# Simple Roblox-style kick menu system in Python

class KickMenu:
    def __init__(self):
        self.players = ['Player1', 'Player2', 'Player3', 'Player4']
        self.kicked = []
    
    def display_menu(self):
        print('=== KICK MENU ===')
        for i, player in enumerate(self.players, 1):
            print(f'{i}. {player}')
        print(f'{len(self.players) + 1}. Exit')
    
    def kick_player(self, player_index):
        if 0 <= player_index < len(self.players):
            player = self.players.pop(player_index)
            self.kicked.append(player)
            print(f'✓ {player} has been kicked!')
        else:
            print('Invalid selection')
    
    def run(self):
        while len(self.players) > 0:
            self.display_menu()
            try:
                choice = int(input('Select player to kick: ')) - 1
                if choice == len(self.players):
                    break
                self.kick_player(choice)
            except ValueError:
                print('Invalid input')
        print(f'\nKicked players: {self.kicked}')

# Demo without user input
menu = KickMenu()
menu.display_menu()
menu.kick_player(0)
menu.kick_player(1)
print(f'\nRemaining players: {menu.players}')
print(f'Kicked players: {menu.kicked}')
