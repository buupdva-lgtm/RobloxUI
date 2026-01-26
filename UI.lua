# Simple Kick Player Menu System

class PlayerMenu:
    def __init__(self):
        self.players = ['Alice', 'Bob', 'Charlie', 'Diana', 'Eve']
    
    def display_menu(self):
        print("\n=== Kick Player Menu ===")
        print("Current Players:")
        for i, player in enumerate(self.players, 1):
            print(f"{i}. {player}")
        print(f"{len(self.players) + 1}. Exit")
    
    def kick_player(self, choice):
        if 1 <= choice <= len(self.players):
            kicked = self.players.pop(choice - 1)
            print(f"✓ {kicked} has been kicked from the game.")
            return True
        elif choice == len(self.players) + 2:
            return False
        else:
            print("Invalid choice. Please try again.")
            return True
    
    def run(self):
        while True:
            self.display_menu()
            try:
                choice = int(input("Select player to kick (or exit): "))
                if not self.kick_player(choice):
                    print("Exiting menu...")
                    break
            except ValueError:
                print("Please enter a valid number.")

# Demo: Simulate kicking players without user input
menu = PlayerMenu()
print("Initial players:", menu.players)
menu.kick_player(2)  # Kick Bob
print("After kicking:", menu.players)
menu.kick_player(1)  # Kick Alice
print("Final players:", menu.players)
