import os
import re
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.io as pio
import plotly.graph_objects as go
from pathlib import Path
from glob import glob
import base64
from io import BytesIO

COLUMN_DESCRIPTIONS = {
    "total_reads": "Total number of reads sequenced in the sample.",
    "mapped_reads": "Number of reads that successfully mapped to the reference genome.",
    "meanReads": "Mean read depth across the entire genome, including uncovered positions.",
    "sd_reads": "Standard deviation of the read depth across all genomic positions.",
    "median_reads": "Median read depth across the genome.",
    "min_reads": "Minimum depth observed at any position in the genome.",
    "max_reads": "Maximum depth observed at any position in the genome.",
    "basesCovered_1": "Number of bases covered by at least 1 reads.",
    "basesCovered_5": "Number of bases covered by at least 5 reads.",
    "basesCovered_20": "Number of bases covered by at least 20 reads.",
		"basesCovered_100": "Number of bases covered by at least 100 reads.",
		"basesCovered_200": "Number of bases covered by at least 200 reads..",
		"nonMaskedConsensusCov": "Number of unmasked bases in the final consensus sequence.",
}

column_names = {"total_reads": "Total reads", "mapped_reads" : "Mapped reads", "meanReads": "Mean reads", "sd_reads": "Standard deviation", "median_reads": "Median reads", "min_reads": "Minimum reads", "basesCovered_1": "Bases covered 1x", "basesCovered_5": "Bases covered 5x", "basesCovered_20": "Bases covered 20x", "basesCovered_100": "Bases covered 100x", "basesCovered_200": "Bases covered 200x", "nonMaskedConsensusCov": "Nonmasked consensus coverage"}

def extract_lab(row):
    if row['CorrectlyPaired'] == 1:
        match = re.search(r'_(\d+)_LEFT|_RIGHT', str(row['Primer1']))
        return match.group(1) if match else None
    else:
        match = re.match(r'.*?_(\d+)_LEFT.*?_(\d+)_RIGHT', str(row['PrimerPair']))
        return f"{match.group(1)}/{match.group(2)}" if match else None

def plot_primer_products_static(aln_df):
    aln_df['size'] = aln_df['End'].astype(int) - aln_df['Start'].astype(int)
    aln_df['lab'] = aln_df.apply(extract_lab, axis=1)

    grouped = (
        aln_df.groupby(['PrimerPair', 'Start', 'End', 'size', 'CorrectlyPaired', 'lab'])
        .size()
        .reset_index(name='Count')
    )
    filtered = grouped[(grouped['size'] >= 300)]
    filtered['log10_count'] = np.log10(filtered['Count'])

    fig = go.Figure()
    for _, row in filtered.iterrows():
        fig.add_trace(go.Scatter(
            x=[row['Start'], row['End']],
            y=[row['log10_count'], row['log10_count']],
            mode='lines+text',
            line=dict(
                color='blue' if row['CorrectlyPaired'] == 1 else 'red',
                width=2
            ),
            text=[row['lab'], ''],
            textposition='top center',
            name=f"{'Correct' if row['CorrectlyPaired'] == 1 else 'Incorrect'} - {row['lab']}",
            showlegend=False
        ))

    fig.add_hline(y=np.log10(20), line_color="red", line_dash="solid")
    fig.add_hline(y=2, line_color="red", line_dash="dash")

    fig.update_layout(
        title="Primer Product Coverage",
        xaxis_title="Position in genome",
        yaxis_title="log10(Read Count)",
        template="plotly_white",
        height=600,
        width=1200,
        hovermode='closest'
    )

    return pio.to_html(fig, include_plotlyjs='cdn', full_html=False)

def proportion_correctly_paired(aln_df):
    summary = (
        aln_df.groupby('CorrectlyPaired')
        .size()
        .reset_index(name='n')
        .sort_values(by='CorrectlyPaired')
    )
    summary['proportion'] = summary['n'] / summary['n'].sum()
    return summary.to_html(index=False)

def plot_product_size_histogram(aln_df):
    if aln_df.empty or 'Start' not in aln_df.columns or 'End' not in aln_df.columns:
        return "<p><em>No valid data available to generate histogram.</em></p>"

    aln_df['size'] = aln_df['End'].astype(int) - aln_df['Start'].astype(int)

    if aln_df['size'].dropna().empty:
        return "<p><em>No product sizes available for histogram.</em></p>"

    plt.figure(figsize=(10, 6))
    try:
        sns.histplot(data=aln_df, x='size', hue='CorrectlyPaired', bins=50,
                     palette={0: 'red', 1: 'blue'}, alpha=0.7)
        plt.xlabel("Product size (bp)")
        plt.ylabel("Count")
        plt.title("Distribution of Product Sizes by Correct Pairing")
        plt.grid(True)
        plt.tight_layout()

        buffer = BytesIO()
        plt.savefig(buffer, format='png')
        buffer.seek(0)
        img_base64 = base64.b64encode(buffer.read()).decode('utf-8')
        plt.close()
        return f'<img src="data:image/png;base64,{img_base64}" width="800"/>'
    except Exception as e:
        plt.close()
        return f"<p><em>Failed to plot histogram: {str(e)}</em></p>"

def generate_report(alignreport_dir, summary_stats_file, output_dir="summary_report_output"):
    df_summary = pd.read_csv(summary_stats_file, sep='\t')
    output_path = Path(output_dir)
    output_path.mkdir(exist_ok=True)
    report_file = output_path / "combined_summary_report.html"

    alignreport_files = sorted(glob(os.path.join(alignreport_dir, "*.txt")))
    numeric_cols = [col for col in df_summary.select_dtypes(include='number').columns if col != "sample_id"]
    nav_links = [f'<a href="#plot-{col}">{column_names.get(col, col)}</a>' for col in numeric_cols]
    html_sections = []

    for col in numeric_cols:
        fig = px.bar(df_summary, x="sample_id", y=col,
                     color_discrete_sequence=["#2a9d8f"])
        fig.update_layout(xaxis_tickangle=-45, width=1400)
        fig_html = pio.to_html(fig, include_plotlyjs='cdn', full_html=False)
        section = f"""
        <div id="plot-{col}" style="margin: 30px 0; padding: 20px; border: 1px solid #ccc; border-radius: 10px;
                                    box-shadow: 2px 2px 12px rgba(0,0,0,0.1); background-color: #f9f9f9;">
            <p>{COLUMN_DESCRIPTIONS.get(col, f"This plot shows <strong>{col}</strong> for each sample.")}</p>
            <div style="overflow-x:auto;"><div style="min-width: 1400px;">{fig_html}</div></div>
        </div>
        """
        html_sections.append(section)

    for filepath in alignreport_files:
        if ".alignreport.txt" in filepath:
            sample_id = os.path.basename(filepath).replace(".txt", "")
            aln_df = pd.read_csv(filepath, sep='\t')
            if aln_df.empty:
                print(f"Skipping empty file: {filepath}")
                continue

            primer_plot_html = plot_primer_products_static(aln_df)
            summary_df = aln_df['CorrectlyPaired'].value_counts().to_dict()
            total = sum(summary_df.values())
            correct = summary_df.get(1, 0)
            proportion_correct = correct / total if total > 0 else 0

            if proportion_correct >= 0.8:
                status_symbol = "✅"
                proportion_tag = f"<p style='color:green; font-weight:bold;'>✔ Good Library: {proportion_correct:.1%} correctly paired</p>"
            else:
                status_symbol = "❌"
                proportion_tag = f"<p style='color:red; font-weight:bold;'>✘ Poor Library: Only {proportion_correct:.1%} correctly paired</p>"

            proportion_table_html = proportion_correctly_paired(aln_df) + proportion_tag
            histogram_html = plot_product_size_histogram(aln_df)

            nav_links.append(f'<a href="#primer-{sample_id}">{status_symbol} Primer: {sample_id}</a>')
            html_sections.append(f"""
            <div id="primer-{sample_id}" style="margin: 50px 0;">
             <h2>Primer Product Coverage — {sample_id}</h2>
             {primer_plot_html}
             <h3>Correctly Paired Summary</h3>
             {proportion_table_html}
             <h3>Product Size Distribution</h3>
             {histogram_html}
          </div>
<hr style="margin-top: 40px; border: 0; border-top: 2px dashed #ccc;"/>
        """)

    final_html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <title>Combined Sequencing Report</title>
        <style>
            body {{ font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background-color: #f0f2f5; }}
            .container {{ display: flex; }}
            .sidebar {{ width: 250px; background-color: #2a9d8f; padding: 30px 20px; height: 100vh; position: fixed; overflow-y: auto; color: white; }}
            .sidebar h2 {{ color: white; margin-top: 0; }}
            .sidebar a {{ display: block; color: white; margin-bottom: 10px; text-decoration: none; font-weight: 500; }}
            .sidebar a:hover {{ text-decoration: underline; }}
            .main {{ margin-left: 270px; padding: 40px; width: 100%; overflow-x: hidden; }}
            h1 {{ color: #2c3e50; margin-bottom: 40px; }}
            h3 {{ color: #2c3e50; }}
            p {{ color: #444; }}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <h2>Plots</h2>
                {''.join(nav_links)}
            </div>
            <div class="main">
                <h1>Sequencing Report</h1>
                {''.join(html_sections)}
            </div>
        </div>
    </body>
    </html>
    """

    with open(report_file, "w") as f:
        f.write(final_html)

    print(f"Combined report generated: {report_file.resolve()}")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Generate a sequencing report from align reports and summary stats.")
    parser.add_argument("--alignreport_dir", required=True, help="By default it should be results/medaka directory")
    parser.add_argument("--summary_stats_file", required=True, help="Path to summary_stats.txt file")
    parser.add_argument("--output_dir", help="Directory to save the report")

    args = parser.parse_args()
    generate_report(args.alignreport_dir, args.summary_stats_file, args.output_dir)

