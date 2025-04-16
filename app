import database

MENU_PROMPT = """

Please select one of the following options:

1. Add a new bean.
2. See all beans.
3. Find a bean by name.
4. See which preparation method is best for your beans.
5. 
6. EXIT.

Your selection: 

"""

GET_BEST_PREPARATION_FOR_BEAN = """
SELECT * FROM beans
WHERE name = ? AND rating = (SELECT MAX(rating) FROM beans WHERE name = ?)
"""

def menu():
    connection = database.connect()
    database.create_tables(connection)

    while (user_input := input(MENU_PROMPT)) != "5":
        if user_input == "1":
            bean_function(connection)
           
        elif user_input == "2":
            bean_function2(connection)

        elif user_input == "3":
            bean_function3(connection)

        elif user_input == "4":
            bean_function4(connection)
  
        else:
            print("Invalid selection. Please try again.")

def bean_function4(connection):
    name = input("Enter the name of the bean: ")
    best_preparation = database.get_best_preparation_for_bean(connection, name)

    print(f"The best preparation method for: {name} is: {best_preparation[2]}")

def bean_function3(connection):
    name = input("Enter the name of the bean: ")
    beans = database.get_beans_by_name(connection, name)

    for bean in beans:
        print(f"{bean[1]}, - {bean[2]}, - {bean[3]}/100")

def bean_function2(connection):
    beans = database.get_all_beans(connection)

    for bean in beans:
        print(f"{bean[1]}, - {bean[2]}, - {bean[3]}/100")

def bean_function(connection):
    name = input("Enter the name of the bean: ")
    method = input("Enter the preparation method: ")
    rating = int(input("Enter the rating (0-100): "))

    database.add_bean(connection, name, method, rating)



menu()
