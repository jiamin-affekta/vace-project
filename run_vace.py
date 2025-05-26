import gradio as gr
import subprocess
import os

def generate_video(text, voice_type):
    # Save the input as a config file (can also dynamically construct a YAML)
    config_path = "configs/tmp.yaml"
    with open(config_path, "w") as f:
        f.write(f"prompt: \"{text}\"\n")
        f.write(f"voice: \"{voice_type}\"\n")

    # Run the VACE script (assuming dependencies are installed and script is in the current directory)
    try:
        subprocess.run(["python", "run_vace.py", "--config", config_path], check=True)
    except subprocess.CalledProcessError:
        return "Generation failed. Please check the logs.", None

    # Assume the output video path is output/result.mp4
    video_path = "output/result.mp4"
    if os.path.exists(video_path):
        return "Generation successful!", video_path
    else:
        return "Video generation failed.", None

# GUI layout
with gr.Blocks() as demo:
    gr.Markdown("## 🎬 VACE Video Generator")
    text_input = gr.Textbox(lines=4, label="Enter video script or prompt")
    voice_dropdown = gr.Dropdown(choices=["girl", "boy", "woman", "man"], value="girl", label="Voice type")
    generate_btn = gr.Button("Generate Video")
    status_output = gr.Textbox(label="Status")
    video_output = gr.Video(label="Preview Generated Video")

    generate_btn.click(fn=generate_video, inputs=[text_input, voice_dropdown], outputs=[status_output, video_output])

# Launch the GUI
demo.launch()
