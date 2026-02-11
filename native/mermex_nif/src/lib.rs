use mermaid_rs_renderer::render as mermaid_render;

#[rustler::nif]
fn render(diagram: &str) -> Result<String, String> {
    mermaid_render(diagram).map_err(|e| e.to_string())
}

rustler::init!("Elixir.Mermex");
