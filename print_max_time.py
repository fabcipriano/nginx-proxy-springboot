import re

# Function to parse log file and find max rt and urt values
def find_max_rt_urt(file_path):
    # Regular expression to extract rt and urt values
    pattern = r'(\d{3}) .* rt=(\d+\.\d+) urt=(\d+\.\d+)'
    
    # Initialize variables to store the maximum values
    max_rt = 0.0
    max_urt = 0.0
    max_rt_line = ""
    max_urt_line = ""
    non_200_count = 0
    non_200_lines = []  # List to store lines with status code different from 200

    
    # Open the log file and read line by line
    with open(file_path, 'r') as file:
        for line in file:
            # Search for rt and urt values in the current line
            match = re.search(pattern, line)
            if match:
                status_code = int(match.group(1))
                rt_value = float(match.group(2))
                urt_value = float(match.group(3))
                
                # Update max_rt and max_urt if current values are greater
                if rt_value > max_rt:
                    max_rt = rt_value
                    max_rt_line = line
                if urt_value > max_urt:
                    max_urt = urt_value
                    max_urt_line = line
                    
                # Count non-200 status codes
                if status_code != 200:
                    non_200_count += 1
                    non_200_lines.append(line)


    # Output the maximum values
    print(f"Max rt: {max_rt}, line: {max_rt_line}")
    print(f"Max urt: {max_urt}, line: {max_urt_line}")
    print(f"Number of HTTP status codes different from 200: {non_200_count}")

    # Print all lines with status code different from 200
    if non_200_lines:
        print("\nLines with HTTP status code different from 200:")
        for non_200_line in non_200_lines:
            print(non_200_line)


print(f"Reading file ....")
# Specify the path to your log file
log_file_path = '/home/fabiano/dev/nginx-proxy-springboot/nginx-logs/access.log'

print(f"File read.")
# Call the function with the log file path
find_max_rt_urt(log_file_path)