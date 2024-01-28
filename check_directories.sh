#!/bin/bash

# List of directories to check
directories=("weizhou1125917" "ThomasBenny1147993" "robertbarrett23" "granniecode1151134" "jasonlin9011" "fake_account")

# Counter for checking every 100 iterations
counter=0

# Create or truncate the results.txt file
echo -n > results.txt

# Loop through each directory
for dir in "${directories[@]}"; do
    # Check if the directory exists
    if [ -d "/home/$dir" ]; then
        # Change into the directory
        cd "/home/$dir" || exit 1

        # Check if the spb folder exists in the directory
        if [ -d "spb" ]; then
            # Check if app.py file exists in the spb folder
            if [ -f "spb/app.py" ]; then
                echo -e "$dir\t200" >> /home/lincolnmac/results.txt
            else
                
                echo -e "$dir\t401" >> /home/lincolnmac/results.txt
            fi
        else
            
            echo -e "$dir\t402" >> /home/lincolnmac/results.txt
        fi

        # Change back to the original directory
        cd - || exit 1
    else
        echo -e "$dir\t403" >> /home/lincolnmac/results.txt
    fi

    # Increment the counter
    ((counter++))

    # Add a delay after every 100 checks
    if [ $counter -eq 100 ]; then
        echo "Adding a delay..."
        sleep 5  # You can adjust the duration of the delay (in seconds)
        counter=0
    fi
done

# chmod +x check_directories.sh
# ./check_directories.sh

#!/bin/bash

# List of directories to check
directories=("dir1" "dir2" "dir3")

# Counter for checking every 100 iterations
counter=0

# Create or truncate the results.txt file
echo -n > results.txt

# Loop through each directory
for dir in "${directories[@]}"; do
    # Check if the directory exists
    if [ -d "$dir" ]; then
        # Change into the directory
        cd "$dir" || exit 1

        # Find directories that have the name "spb" or start/end with "spb"
        spb_directories=($(find . -type d -name "spb" -o -name "spb*" -o -name "*spb"))

        if [ ${#spb_directories[@]} -eq 0 ]; then
            # No matching directories found
            echo -e "$dir\t402" >> results.txt
        else
            # Prioritize the conditions (200, 401) and take the first match
            found=0

            for spb_dir in "${spb_directories[@]}"; do
                # Check if app.py file exists in the spb folder
                if [ -f "$spb_dir/app.py" ]; then
                    echo -e "$dir/$spb_dir\t200" >> results.txt
                    found=1
                    break
                elif [ $found -eq 0 ]; then
                    echo -e "$dir/$spb_dir\t401" >> results.txt
                fi
            done
        fi

        # Change back to the original directory
        cd - || exit 1
    else
        # Directory does not exist
        echo -e "$dir\t403" >> results.txt
    fi

    # Increment the counter
    ((counter++))

    # Add a delay after every 100 checks
    if [ $counter -eq 100 ]; then
        echo "Adding a delay..."
        sleep 5  # You can adjust the duration of the delay (in seconds)
        counter=0
    fi
done
