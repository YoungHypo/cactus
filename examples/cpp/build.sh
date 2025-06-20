mkdir -p build
cd build
cmake ..
make

# Create Metal library symlink only if not in CI environment
if [[ "$CI" != "true" && "$GITHUB_ACTIONS" != "true" ]]; then
    ln -sf ../../../cactus/ggml-llama.metallib default.metallib
    echo "Created Metal library symlink"
fi