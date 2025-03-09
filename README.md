# Design and Implementation of a 5-band Graphic Equalizer

## Introduction
This project integrates a MATLAB App Designer GUI with a Simulink Model to create a complete audio equalization system. The MATLAB GUI provides an interactive interface for selecting frequency bands, adjusting gain parameters, and visualizing real-time audio changes. Meanwhile, the Simulink Model processes the audio signal, filtering it through specific frequency bands and allowing for dynamic gain modifications. 

By combining Simulink's precision in signal processing with a user-friendly GUI, this project offers a powerful tool for adjusting audio signals efficiently.

## Technical Background

### Simulink Model
- Implements a **multi-filter approach** with five bandpass filters targeting specific frequency bands: **63 Hz, 250 Hz, 1000 Hz, 4000 Hz, and 16000 Hz**.
- Adjustable gain sliders allow precise control over each frequency component.
- Real-time visualization of filtered signals and the final equalized output.

### GUI (MATLAB App Designer)
- Provides an intuitive interface for real-time interaction.
- Includes knobs for selecting frequency bands and sliders for adjusting gain levels.
- Supports audio file loading and playback for enhanced user experience.

### Filter Design
- Uses **Butterworth bandpass filters** to target specific frequency bands.
- Filter parameters:
  - **Order:** Controls roll-off rate and selectivity.
  - **Quality Factor (Q):** Determines bandwidth and frequency selectivity.
  - **Center Frequency (FC):** Represents the midpoint of the targeted frequency band.

## Methodology

### 1. Filter Design (Simulink Model)
- Implements a **5-band graphic equalizer** with adjustable gain sliders.
- Uses Butterworth bandpass filters to process the input audio signal.

```matlab
% Compute Butterworth filter coefficients
function [a,b] = butter_coef()
    Q = 0.85;
    fc = [63 250 1000 4000 16000];
    Fs = 58000;
    for i = 1:5
        fc1 = -fc(i)/(2*Q) + fc(i)*sqrt(1/(Q^2) + 4)/2;
        fc2 = fc(i)/Q + fc1;
        [b{i}, a{i}] = butter(3, [fc1 fc2]/(Fs/2), 'bandpass');
    end
end
```

### 2. Cutoff Frequencies Adjustment
- The cutoff frequency marks the point where a filter reaches -3 dB, indicating the start of attenuation.

### 3. Individual and Combined Frequency Analysis
- Each filter isolates a specific frequency band.
- Filter outputs are combined to generate the final equalized audio signal.

## Simulink Implementation

### 1. Loading Audio Files
- The **LoadFileButton** prompts users to select an audio file (WAV, MP3).
- The file path is displayed on the GUI.

### 2. Equalizer Sliders and Filters
- Gain adjustments from the GUI affect the Butterworth bandpass filters in real time.

### 3. Applying Filters Sequentially
- The **PlayButton** applies filters sequentially, ensuring smooth transitions and optimal audio quality.

```matlab
function PlayButtonPushed(app, event)
    % Code for applying filters and real-time plotting
end
```

## GUI - MATLAB App Designer

### 1. Audio File Processing
- **LoadFileButtonPushed** allows users to select an audio file using `uigetfile`.
- Displays the file path in the GUI.

```matlab
function LoadFileButtonPushed(app, event)
    [file, path] = uigetfile({'*.wav;*.mp3'});
    app.FilePathLabel.Text = fullfile(path, file);
end
```

### 2. Real-time Equalization
- **PlayButtonPushed** loads the original audio, applies Butterworth filters, and visualizes the processed signal.

### 3. Stop Functionality
- **StopButtonPushed** stops the playback using the `stop` function.

```matlab
function StopButtonPushed(app, event)
    stop(app.audioPlayer);
    app.StopButton.Text = 'Stopped';
end
```

### 4. Gain Control via Knobs
- Knobs update labels to display current gain values.

```matlab
function knob1ValueChanged(app, event)
    value = app.knob1.Value;
    app.knob1label.Text = int2str(value);
end
```

### 5. Applying Filters
- Filters are dynamically applied based on user-selected gain values.

```matlab
function data_out = equalizerSlider_63Hz(app, data_in)
    gain = app.knob1.Value;
    orders = 3;
    data_out = app.filterData_1(data_in, orders, gain);
end
```

## Features
- **5-band equalization:** Adjust gain levels for specific frequency bands.
- **Real-time visualization:** View filtered signal changes instantly.
- **User-friendly GUI:** Simple controls for audio selection, playback, and filtering.
- **Efficient filtering:** Butterworth filters ensure smooth transitions and minimal distortion.

## Installation and Usage
1. Clone this repository:
   ```sh
   git clone https://github.com/yourusername/5-band-equalizer.git
   ```
2. Open MATLAB and navigate to the project directory.
3. Run `appdesigner` and open the GUI file.
4. Load an audio file, adjust equalizer settings, and play the filtered audio.

## Future Improvements
- Implement additional filter designs (Chebyshev, Elliptic) for comparison.
- Optimize real-time processing for larger audio files.
- Add an option to export equalized audio.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author
**Abdul Wasay Naveed**
- GitHub: [yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://www.linkedin.com/in/yourprofile)

---
