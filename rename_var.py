import os

def replace_in_file(filepath):
    print("Processing", filepath)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    new_content = content.replace('todayExercises', 'exercisesList')

    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print("  Replaced in", filepath)

def main():
    lib_path = os.path.join(os.getcwd(), 'lib')
    for root, dirs, files in os.walk(lib_path):
        for file in files:
            if file.endswith('.dart'):
                replace_in_file(os.path.join(root, file))

if __name__ == '__main__':
    main()

