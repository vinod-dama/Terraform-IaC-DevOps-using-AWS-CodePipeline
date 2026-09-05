#!/bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
sudo dnf update -y
sudo dnf install -y httpd
sudo systemctl enable httpd
sudo service httpd start  

# Create Fun & Engaging Dual-Identity Index Page
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vinod | Code & Travel Voyage</title>
    <style>
        :root {
            --primary: #FF385C;
            --secondary: #00A699;
            --dark: #1E293B;
            --light: #F8FAFC;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            color: #E2E8F0;
            margin: 0;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            text-align: center;
        }
        .hero-badge {
            display: inline-block;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
            font-weight: bold;
            padding: 8px 18px;
            border-radius: 50px;
            font-size: 0.9rem;
            letter-spacing: 1px;
            margin-bottom: 15px;
            text-transform: uppercase;
        }
        h1 {
            font-size: 2.2rem;
            margin: 10px 0;
            background: linear-gradient(to right, #38BDF8, #818CF8, #F472B6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        p.tagline {
            font-size: 1.1rem;
            color: #94A3B8;
            max-width: 650px;
            margin: 0 auto 30px auto;
            line-height: 1.6;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
            padding: 15px;
            border-radius: 12px;
        }
        .stat-card h3 {
            margin: 0;
            font-size: 1.4rem;
            color: #F3F4F6;
        }
        .stat-card p {
            margin: 5px 0 0 0;
            font-size: 0.85rem;
            color: #9CA3AF;
        }
        .video-wrapper {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 aspect ratio */
            height: 0;
            overflow: hidden;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            border: 2px solid rgba(255, 255, 255, 0.1);
        }
        .video-wrapper iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0;
        }
        .cta-buttons {
            margin-top: 35px;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn {
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 56, 92, 0.4);
        }
        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="hero-badge">⚡ Where Code Meets Adventure</div>
        <h1>AWS Multi-Env Infrastructure × Vino's Voyage</h1>
        <p class="tagline">
            Built completely using zero-touch <b>Terraform & AWS CodePipeline</b> on one side—and powered by the wanderlust of <b>Vino's Voyage</b> on the other! 
            One engine running code, content, and continuous deployment.
        </p>

        <div class="stats-grid">
            <div class="stat-card">
                <h3>🚀 100% Automated</h3>
                <p>Zero-Touch CI/CD Pipeline</p>
            </div>
            <div class="stat-card">
                <h3>🛠️ Multi-Env IaC</h3>
                <p>Dev & Stage on AWS</p>
            </div>
            <div class="stat-card">
                <h3>🎥 Vino's Voyage</h3>
                <p>Travel & Exploration</p>
            </div>
        </div>

        <div class="video-wrapper">
            <iframe src="https://www.youtube.com/@VinoSVoyage" allowfullscreen></iframe>
        </div>

        <div class="cta-buttons">
            <a href="https://www.youtube.com/@VinoSVoyage" target="_blank" class="btn btn-primary">✈️ Subscribe to Vino's Voyage</a>
            <a href="/app1/metadata.html" class="btn btn-secondary">🔍 View EC2 Metadata (IMDSv2)</a>
        </div>
    </div>

</body>
</html>
EOF

# Fetch EC2 Instance Identity Metadata (IMDSv2)
sudo mkdir -p /var/www/html/app1
TOKEN=$(curl -s -S -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
sudo curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html