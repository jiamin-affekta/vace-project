import gradio as gr
import subprocess
import os

def generate_video(text, voice_type):
    # 将输入保存为 config 文件（也可以动态构建 yaml）
    config_path = "configs/tmp.yaml"
    with open(config_path, "w") as f:
        f.write(f"prompt: \"{text}\"\n")
        f.write(f"voice: \"{voice_type}\"\n")

    # 调用 VACE 脚本（假设已经安装依赖并在当前目录）
    try:
        subprocess.run(["python", "run_vace.py", "--config", config_path], check=True)
    except subprocess.CalledProcessError:
        return "生成失败，请检查日志", None

    # 输出路径假设为 output/result.mp4
    video_path = "output/result.mp4"
    if os.path.exists(video_path):
        return "生成成功！", video_path
    else:
        return "视频生成失败", None

# GUI 界面布局
with gr.Blocks() as demo:
    gr.Markdown("## 🎬 VACE 视频生成器")
    text_input = gr.Textbox(lines=4, label="请输入视频脚本或提示词")
    voice_dropdown = gr.Dropdown(choices=["girl", "boy", "woman", "man"], value="girl", label="声音类型")
    generate_btn = gr.Button("生成视频")
    status_output = gr.Textbox(label="状态")
    video_output = gr.Video(label="预览生成视频")

    generate_btn.click(fn=generate_video, inputs=[text_input, voice_dropdown], outputs=[status_output, video_output])

# 启动 GUI
demo.launch()
