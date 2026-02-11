use mermaid_rs_renderer::{render_with_options, RenderOptions};

#[derive(rustler::NifMap)]
struct Opts {
    font_family: Option<String>,
    font_size: Option<f64>,
    node_spacing: Option<f64>,
    rank_spacing: Option<f64>,
}

#[rustler::nif]
fn native_render(diagram: &str, opts: Opts) -> Result<String, String> {
    let mut render_opts = RenderOptions::modern();

    if let Some(ref font_family) = opts.font_family {
        render_opts.theme.font_family = font_family.clone();
    }
    if let Some(font_size) = opts.font_size {
        render_opts.theme.font_size = font_size as f32;
    }
    if let Some(node_spacing) = opts.node_spacing {
        render_opts.layout.node_spacing = node_spacing as f32;
    }
    if let Some(rank_spacing) = opts.rank_spacing {
        render_opts.layout.rank_spacing = rank_spacing as f32;
    }

    render_with_options(diagram, render_opts).map_err(|e| e.to_string())
}

rustler::init!("Elixir.Mermex");
