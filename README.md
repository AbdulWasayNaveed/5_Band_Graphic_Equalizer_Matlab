# 5-Band Graphic Equalizer

Project Overview

This project implements a 5-Band Graphic Equalizer using MATLAB App Designer and Simulink. The equalizer allows users to adjust the gain of five frequency bands to enhance or suppress specific frequencies in an audio signal. It includes both real-time visualization and filtering capabilities.

Features

5 Frequency Bands: Users can control gain for different frequency ranges.

Real-Time Processing: Visualize changes in time and frequency domains.

Customizable UI: User-friendly interface designed in MATLAB App Designer.

Simulink Integration: Uses Simulink for real-time audio filtering.

Powerful Audio Processing: Implements FIR and IIR filters for precise equalization.

Installation and Setup

Requirements

MATLAB (R2021a or later)

MATLAB App Designer

Simulink

Signal Processing Toolbox

Audio Toolbox (recommended for real-time audio processing)

Steps to Run the Application

Clone or download the repository.

Open MATLAB and navigate to the project folder.

Open the EqualizerApp.mlapp file in MATLAB App Designer.

Run the app and load an audio file.

Adjust frequency band sliders to modify the audio signal in real-time.

Observe the changes in the waveform and spectrum plots.

File Structure

EqualizerApp.mlapp – Main MATLAB App Designer file.

equalizer_simulink.slx – Simulink model for real-time filtering.

filters.m – MATLAB script defining FIR/IIR filter parameters.

README.md – Documentation for the project.

How It Works

Load Audio: The user loads an audio file via the UI.

Filter Application: The selected gains are applied to predefined FIR/IIR filters.

Visualization: The app displays the time-domain waveform and frequency spectrum.

Real-Time Adjustment: Users can dynamically adjust gain for each band and hear immediate changes.

Future Enhancements

Implement additional filter types (e.g., parametric equalization).

Improve real-time performance with optimized DSP techniques.

Add support for live audio input.

Contributors

Abdul Wasay Naveeed

License

This project is licensed under the MIT License. Feel free to modify and distribute it.

Contact

For any questions or suggestions, feel free to reach out via GitHub or email.
