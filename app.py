from flask import Flask, jsonify, request, send_file, render_template, send_from_directory
import os
import subprocess

app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
OUTPUT_FOLDER = 'outputs'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(OUTPUT_FOLDER, exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        file = request.files['datafile']
        input_path = os.path.join('uploads', 'input.csv')
        output_path = os.path.join('outputs', 'predicted_output.csv')
        file.save(input_path)

        # Run the R script
        subprocess.run([
            r'D:\Program Files\R-4.3.2\bin\Rscript.exe', 
            'main.R', input_path, output_path
        ], check=True)

        # Return JSON with download URL
        return jsonify({"download_url": "/download"})

    except subprocess.CalledProcessError as e:
        return jsonify({"error": "Prediction failed."}), 500

@app.route('/download')
def download_file():
    return send_from_directory('outputs', 'predicted_output.csv', as_attachment=True)


if __name__ == "__main__":
    app.run(debug=True)
