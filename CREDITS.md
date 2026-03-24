# Credits & Attribution

This project builds upon the exceptional work of the AI music generation community and was co-created through human-AI collaboration. We are deeply grateful to all contributors who made this possible.

---

## 🤖 Co-Creator: Claude by Anthropic

**AI Partner**: [Claude](https://www.anthropic.com/claude)  
**Developer**: Anthropic  
**Role**: AI pair programming collaborator  

### Collaboration Details

This project was built through **human-AI pair programming** with Claude assisting in:

- **Architecture & Design**: Web interface design, API structure, workflow optimization
- **Code Development**: Flask application, integration layer, security implementation
- **Documentation**: README, security audit reports, setup guides, attribution files
- **Security Review**: Comprehensive scanning for credentials, .gitignore configuration
- **Best Practices**: Open source compliance, proper attribution, license compatibility
- **Problem Solving**: Debugging, optimization suggestions, error handling

### Philosophy

This project demonstrates the potential of **human-AI collaboration** in software development:
- **Human vision & creativity** + **AI execution & thoroughness**
- **Human domain expertise** + **AI technical knowledge**
- **Human decision-making** + **AI assistance at scale**

Claude served as an **AI collaborator**, not just a tool — contributing ideas, catching errors, suggesting improvements, and helping maintain best practices throughout the development process.

### About Claude

Claude is a next-generation AI assistant built by Anthropic, focused on being helpful, harmless, and honest. In this project, Claude functioned as a **pair programming partner**, bringing:
- Deep technical knowledge across languages and frameworks
- Attention to security and best practices
- Thorough documentation capabilities
- Rapid prototyping and iteration

**Learn more**: https://www.anthropic.com/claude

---

## 🎵 Foundation Model: ACE-Step

**Project**: [ACE-Step](https://github.com/ace-step/ACE-Step)  
**Authors**: ChuxiJ, DumoeDss, and team  
**License**: Apache 2.0  
**Stars**: 4.2k ⭐  

### About ACE-Step

ACE-Step is a breakthrough open-source foundation model for music generation that achieves state-of-the-art performance through:

- **Diffusion-based generation** with Deep Compression AutoEncoder (DCAE)
- **Lightweight linear transformer** for efficient processing
- **REPA alignment** using MERT and m-hubert for semantic representations
- **15× faster** than LLM-based baselines (4 minutes of music in 20 seconds on A100)
- **Advanced control**: Voice cloning, lyric editing, remixing, track generation

### Citation

If you use this project in research, please cite the original ACE-Step paper:

```bibtex
@article{ace-step-2024,
  title={ACE-Step: A Step Towards Music Generation Foundation Model},
  author={ChuxiJ and DumoeDss and team},
  journal={GitHub},
  year={2024},
  url={https://github.com/ace-step/ACE-Step}
}
```

### Links
- **GitHub**: https://github.com/ace-step/ACE-Step
- **Paper**: Available in repository
- **Hugging Face**: https://huggingface.co/ACE-Step
- **Website**: https://acestudio.ai/

---

## ⚙️ Inference Engine: acestep.cpp

**Project**: [acestep.cpp](https://github.com/ServeurpersoCom/acestep.cpp)  
**Author**: ServeurpersoCom  
**License**: MIT  
**Stars**: 151 ⭐  

### About acestep.cpp

Portable C++17 implementation of ACE-Step 1.5 for efficient local inference:

- **GGML-based**: Quantized model support (Q4_K_M, Q5_K_M, Q8_0)
- **Multi-platform**: CPU, CUDA, ROCm, Metal, Vulkan
- **Efficient**: Runs on consumer hardware with quantized models
- **Portable**: Single binary, no Python dependencies for inference

### Key Features
- Text + lyrics → stereo 48kHz audio
- CMake build system for cross-platform compilation
- Metal acceleration on macOS (automatic detection)
- Memory-efficient quantization strategies

### Links
- **GitHub**: https://github.com/ServeurpersoCom/acestep.cpp
- **License**: MIT (full text in submodule)

---

## 🤖 Model Weights

**Repository**: [Serveurperso/ACE-Step-1.5-GGUF](https://huggingface.co/Serveurperso/ACE-Step-1.5-GGUF)  
**Provider**: Serveurperso (Hugging Face)  
**Format**: GGUF (quantized)  

### Available Models

#### Language Models
- `acestep-5Hz-lm-0.6B-Q8_0.gguf` (710 MB) — Fast
- `acestep-5Hz-lm-1.7B-Q8_0.gguf` (1.98 GB) — Balanced
- `acestep-5Hz-lm-4B-Q5_K_M.gguf` (3.03 GB) — Quality

#### DiT Models
- `acestep-v15-turbo-Q4_K_M.gguf` (1.45 GB) — Fastest
- `acestep-v15-turbo-Q5_K_M.gguf` (1.70 GB) — Balanced
- `acestep-v15-base-Q4_K_M.gguf` (1.45 GB) — Base
- `acestep-v15-sft-Q4_K_M.gguf` (1.45 GB) — Steered

#### Support Models
- `Qwen3-Embedding-0.6B-Q8_0.gguf` (784 MB) — Text encoder
- `vae-BF16.gguf` (337 MB) — VAE decoder

### Links
- **Hugging Face**: https://huggingface.co/Serveurperso/ACE-Step-1.5-GGUF

---

## 🧠 AI Composition Feature

**Provider**: [Anthropic](https://www.anthropic.com/)  
**Model**: Claude 3.5 Haiku  
**API**: https://docs.anthropic.com/

The AI composition feature uses Anthropic's Claude API to:
- Generate song structure from user ideas
- Create lyrics with proper formatting
- Suggest style/genre/mood tags for music generation

Users provide their own API keys (not included).

**Note**: Claude also co-created this integration project as an AI pair programming partner (see Co-Creator section above).

---

## 🛠️ Core Dependencies

### GGML
**Project**: [ggml](https://github.com/ggerganov/ggml)  
**Author**: Georgi Gerganov  
**License**: MIT  

Low-level tensor library powering efficient ML inference. Used by acestep.cpp for quantized model execution.

### Flask
**Project**: [Flask](https://flask.palletsprojects.com/)  
**License**: BSD-3-Clause  

Python web framework powering the server and API.

### Hugging Face Hub
**Project**: [huggingface_hub](https://github.com/huggingface/huggingface_hub)  
**License**: Apache 2.0  

Used for downloading model weights during setup.

### python-dotenv
**Project**: [python-dotenv](https://github.com/theskumar/python-dotenv)  
**License**: BSD-3-Clause  

Environment variable management for configuration.

---

## 🌐 Related Projects

### ACE-Step DAW
**GitHub**: https://github.com/ace-step/ACE-Step-DAW  

Browser-based Digital Audio Workstation powered by ACE-Step with:
- LEGO-style sequential generation
- Cover generation and vocal extraction
- Piano roll, mixer, timeline editing

### ACE Studio
**Website**: https://acestudio.ai/  

Professional music production platform with:
- Higher quality models
- Real-time collaboration
- Polished workflow
- Cloud inference

---

## 📜 License Summary

| Component | License | Repository |
|-----------|---------|------------|
| **This project** | MIT | https://github.com/inoculate23/squaawke |
| **ACE-Step (models)** | Apache 2.0 | https://github.com/ace-step/ACE-Step |
| **acestep.cpp** | MIT | https://github.com/ServeurpersoCom/acestep.cpp |
| **GGML** | MIT | https://github.com/ggerganov/ggml |
| **Flask** | BSD-3-Clause | https://flask.palletsprojects.com/ |

See individual repositories for full license texts.

---

## 🙏 Acknowledgments

Special thanks to:

1. **Claude by Anthropic** for being an exceptional AI collaborator in building this project
2. **The ACE-Step team** for releasing an open-source foundation model that rivals commercial offerings
3. **ServeurpersoCom** for the portable C++ inference engine enabling local deployment
4. **Serveurperso** for quantized GGUF model conversions
5. **The GGML community** for making efficient ML inference accessible
6. **Anthropic** for Claude API enabling both AI-assisted composition AND project development
7. **The open-source AI community** for advancing music generation technology and embracing human-AI collaboration

---

## 🤝 Contributing

If you improve this project, consider:
- Contributing back to [ACE-Step](https://github.com/ace-step/ACE-Step)
- Reporting bugs/improvements to [acestep.cpp](https://github.com/ServeurpersoCom/acestep.cpp)
- Sharing your generated music with proper attribution

---

## 📞 Support

- **This project**: [GitHub Issues](https://github.com/inoculate23/squaawke/issues)
- **ACE-Step**: [GitHub Issues](https://github.com/ace-step/ACE-Step/issues)
- **acestep.cpp**: [GitHub Issues](https://github.com/ServeurpersoCom/acestep.cpp/issues)

---

*This document is maintained to honor the contributions of the broader community. If attribution is missing or incorrect, please submit an issue.*
