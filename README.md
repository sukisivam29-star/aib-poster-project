# AlphaQuant AI — Indian Stock Market Terminal (NSE & BSE)

A professional-grade, multi-modal financial market trend prediction and quantitative analysis web terminal calibrated specifically for the Indian Stock Market (NSE & BSE) with Rupee (₹) pricing, live TradingView charts, and AI-driven machine learning models.

---

## 🚀 Key Features

1. **Official TradingView Advanced Real-Time Charts**:
   - Integrated live TradingView candlestick charts for all major Indian equities (`NSE:RELIANCE`, `NSE:TCS`, `NSE:HDFCBANK`, `NSE:TATAMOTORS`, etc.) and indices (`NSE:NIFTY50`, `BSE:SENSEX`).
   - Built-in real-time technical studies: RSI(14), Simple Moving Averages (SMA), and Bollinger Bands.

2. **Full Indian Stock Universe (~170+ Listed Companies)**:
   - Comprehensive universe search across Nifty 50, Large Cap, Mid Cap, Small Cap, and sectoral indices (Banking, IT, Auto, Energy, Defense, Pharma, Metals, FMCG).
   - Instant autocomplete with category filter pills and dynamic quote resolution.

3. **Proprietary AI Machine Learning Forecasting Engine**:
   - **4 Comparative Models**: Hybrid CNN-BiLSTM with Attention, Temporal Fusion Transformer (TFT), XGBoost Ensemble, and Random Forest.
   - **AI Forecast Cone**: 15-day projected median price trajectory with 80% and 95% probability envelopes calibrated from live historical volatility and drift.
   - **SHAP Feature Importance**: Real-time explainability breakdown across RSI Momentum, Yield Spread (10Y-2Y), MACD Divergence, ATR Channel, and FinBERT Sentiment.
   - **Walk-Forward Validation Metrics**: Out-of-sample directional hit rate, F1-score, precision, and Sharpe ratio.

4. **Real-Time Technical Indicators**:
   - Real-time consensus gauge (Buy / Neutral / Sell) powered by Wilder's smoothed RSI(14), MACD(12,26,9) histogram, SMA 20 vs 50 cross status, Bollinger Band positioning, ATR(14) in ₹, and Stochastic %K.

5. **FinBERT Real-Time Indian Market Newswire**:
   - Live marquee stream of financial headlines from Investing.com India, Economic Times, Mint, Reuters, and Moneycontrol with FinBERT sentiment classification (Score & Bullish/Bearish tag).

6. **Zero-Dependency Local Server**:
   - Double-clickable `launch_localhost.bat` (and `start.bat`) with a built-in lightweight PowerShell TCP server. Automatically binds to port 8080 and opens your browser without requiring Python, Node.js, or external installations.

---

## 📂 Project Structure

```
stock-ai-platform/
├── index.html                   # Single-page terminal UI & presentation mode
├── launch_localhost.bat         # One-click localhost runner for Windows
├── start.bat                    # Quick alias for launch_localhost.bat
├── server.ps1                   # Standalone zero-dependency HTTP server
├── css/
│   └── styles.css               # Professional dark terminal UI styles
├── js/
│   ├── nse-bse-stocks.js        # Comprehensive Indian stock universe dataset (~170+ stocks)
│   ├── data.js                  # Macroeconomic feeds, live quotes & FinBERT news
│   ├── indicators.js            # Wilder's RSI, MACD, SMA, EMA, Bollinger, ATR, Stochastic
│   ├── ml-engine.js             # CNN-BiLSTM, TFT, XGBoost, SHAP feature importance
│   ├── chart.js                 # HiDPI canvas engine (Candlesticks, AI Cone, RSI)
│   └── app.js                   # Application controller & DOM wiring
├── sample-data/                 # Sample market data files
├── STRUCTURE.md                 # Technical living architectural reference map
└── README.md                    # Project documentation
```

---

## 💻 Getting Started

### Method 1: Local Server (Recommended)
Double-click `launch_localhost.bat` or run:
```bat
start.bat
```
Your default browser will automatically open `http://localhost:8080/`.

### Method 2: Direct Browser Launch
Open `index.html` directly in any modern web browser (Chrome, Edge, Firefox, Brave).
*(Note: An HTTP server via Method 1 is recommended for full TradingView iframe integration and live cross-origin feeds).*

---

## 📜 License
MIT License. Created for quantitative finance research and advanced market analytics.
