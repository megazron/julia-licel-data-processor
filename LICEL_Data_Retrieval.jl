# This code is made by MegaZroN, portfolio https://megazron.com
using Printf
using Plots

# Define input and output paths (modify these paths as needed)
input_path = "path/to/input/file.dat"
output_raw_path = "path/to/output/raw_data.txt"
output_converted_path = "path/to/output/converted_data.txt"
plot_raw_path = "path/to/output/raw_data_plot.png"
plot_converted_path = "path/to/output/converted_data_plot.png"

# Read input file
open(input_path, "r") do input_file
    # Read the header lines (adjust the number of header lines as needed)
    header_lines = [readline(input_file) for _ in 1:3]

    # Read and store the raw data sets
    raw_data_values = UInt32[]
    while !eof(input_file)
        raw_data_value = read(input_file, UInt32)
        push!(raw_data_values, raw_data_value)
    end

    # Write raw data to the output file in LICEL Data format
    open(output_raw_path, "w") do output_raw_file
        # Write the header lines to the output file
        for line in header_lines
            write(output_raw_file, line * "\r\n") # Append CRLF after each line
        end

        # Write the raw data sets to the output file in LICEL Data format
        for raw_data_value in raw_data_values
            write(output_raw_file, @sprintf("%08X\r\n", raw_data_value)) # Append CRLF after each data value
        end
    end

    println("Raw data saved to $output_raw_path")

    # Sample conversion (modify this conversion logic as needed)
    converted_data_values = map(x -> x * 2, raw_data_values)

    # Write the converted data to the output file in LICEL Data format
    open(output_converted_path, "w") do output_converted_file
        # Write the header lines to the output file
        for line in header_lines
            write(output_converted_file, line * "\r\n") # Append CRLF after each line
        end

        # Write the converted data sets to the output file in LICEL Data format
        for converted_data_value in converted_data_values
            write(output_converted_file, @sprintf("%08X\r\n", converted_data_value)) # Append CRLF after each data value
        end
    end

    println("Converted data saved to $output_converted_path")

    # Plot the raw data (customize plot attributes as needed)
    plot_raw = plot(raw_data_values, color=:red, xlabel="Index", ylabel="Raw Data Value", title="Raw Data Representation")
    savefig(plot_raw, plot_raw_path)

    # Plot the converted data (customize plot attributes as needed)
    plot_converted = plot(converted_data_values, color=:blue, xlabel="Index", ylabel="Converted Data Value", title="Converted Data Representation")
    savefig(plot_converted, plot_converted_path)

    println("Plots saved to $plot_raw_path and $plot_converted_path")
end