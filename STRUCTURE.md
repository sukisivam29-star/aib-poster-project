# AlphaQuant AI — Project Structure Reference

> **Purpose:** Living reference map. Update this file after every structural change. Never re-read source files to understand layout — consult this first.

---

## 📁 File Tree

```
d:\stock-ai-platform\
├── index.html              ← Single-page app shell (all sections defined here)
├── launch_localhost.bat    ← Double-clickable batch file to view in localhost:8080
├── start.bat               ← Quick alias for launch_localhost.bat
├── upload_to_github.bat    ← Automated helper to init, commit, and push project to GitHub
├── server.ps1              ← Standalone PowerShell TCP static server (zero dependencies)
├── css/
│   └── styles.css          ← All styles, ordered by section number
├── js/
│   ├── nse-bse-stocks.js   ← Comprehensive Indian stock dataset (~170+ listed companies)
│   ├── data.js             ← Asset definitions, live quote fetch, macro & news feeds
│   ├── indicators.js       ← SMA, EMA, RSI (Wilder's), MACD, Bollinger, ATR, Stochastic
│   ├── ml-engine.js        ← ML model scoring, forecast cone, SHAP feature importance
│   ├── chart.js            ← Canvas chart engine (FinancialChart + RSISubChart)
│   └── app.js              ← AppController: wires TradingView ↔ DOM ↔ data ↔ indicators
├── sample-data/
│   ├── investing_com_nvda_sample.csv
│   └── investing_com_aapl_sample.csv
├── README.md
└── STRUCTURE.md            ← THIS FILE
```

---

## 🗂️ index.html — Page Structure (top → bottom)

| # | HTML Section | Element / ID | Description |
|---|---|---|---|
| 1 | **Ticker Tape** | `div.ticker-tape` | Marquee bar. INR prices, live USD/INR (₹86.85) and INR/USD ($0.0115). |
| 2 | **Main Header** | `header.main-header` | Branding, "Sync Live Feed" btn, Poster Mode btn, Print btn |
| 3 | **Poster Banner** | `div.poster-only-banner#posterHeaderBanner` | Hidden by default; shown in presentation mode |
| 4 | **Search Section** | `section.search-universe-section` | Search bar + category filter pills |
| 4a | — Search bar | `input#stockSearchInput` | Autocomplete for ~170+ Indian NSE/BSE listed companies |
| 4b | — Dropdown | `div#searchResultsDropdown` | Populated by `app.js` using `searchIndianStocks()` |
| 4c | — Filter pills | `div#categoryFilterBar` | ALL / NIFTY50 / INDICES / BANKING / TECH / AUTO / ENERGY / DEFENSE |
| 5 | **Quick Asset Bar** | `nav.asset-bar#quickAssetBar` | Quick-select buttons for popular Indian equities |
| 6 | **Dashboard Grid** | `main.dashboard-grid` | 3-column layout: Left \| Center \| Right |
| 6L | — Left Column | `aside.col-left` | Macro feeds, Real-time technical indicators table, News feed |
| 6C | — Center Column | `section.col-center` | Asset header, Mode switcher, TradingView real-time chart, AI Forecast Canvas |
| 6R | — Right Column | `aside.col-right` | AI model selector, prediction verdict, SHAP feature bars |
| 7 | **Bottom Suite** | — | **REMOVED** (Quantitative Strategy Backtest Simulator column deleted per user request) |

---

## 🎛️ Key Element IDs (grouped)

### Asset / Header
| ID | Type | Purpose |
|---|---|---|
| `currentAssetName` | `h2` | Full company name |
| `currentAssetSymbol` | `span.symbol-tag` | Ticker symbol badge |
| `currentAssetExchangeTag` | `span.exchange-tag` | NSE / BSE badge |
| `currentAssetExchange` | `p` | "NSE: RELIANCE • Sector • Data source" |
| `displayCurrentPrice` | `div.current-price` | Live price in ₹ |
| `displayExpectedReturn` | `div.stat-badge` | "±X% (5-Day Target: ₹YYYY)" |

### Overlay Toggles
| ID | Type | Purpose |
|---|---|---|
| `toggleSMA20` | checkbox | Shows/hides SMA 20 (amber) |
| `toggleSMA50` | checkbox | Shows/hides SMA 50 (blue) |
| `toggleBollinger` | checkbox | Shows/hides Bollinger bands |
| `toggleForecastCone` | checkbox | Shows/hides AI forecast cone |

### Chart Containers
| ID | Height | Purpose |
|---|---|---|
| `masterChartContainer` | 420px | Main candlestick + overlays + forecast canvas |
| `rsiChartContainer` | 110px | RSI(14) subchart canvas |

### AI Panel (Right Column)
| ID | Purpose |
|---|---|
| `modelSelector` | `<select>` — CNN_LSTM / TRANSFORMER / XGBOOST / RANDOM_FOREST |
| `aiSignalPill` | STRONG BUY / BUY / HOLD / SELL / STRONG SELL pill |
| `probUpBar` / `probUpText` | Bullish probability bar + label |
| `probDownBar` / `probDownText` | Bearish probability bar + label |
| `metricAccuracy` | Directional hit rate % |
| `metricF1` | F1 score |
| `metricPrecision` | Precision (Up) |
| `metricSharpe` | Sharpe ratio |
| `featureImportanceList` | SHAP bars container — populated by `app.js` |

### Left Column
| ID | Purpose |
|---|---|
| `macroGrid` | Macro indicators grid — populated by `app.js` |
| `techSummaryBadge` | BUY / SELL badge |
| `techVotesBreakdown` | "X Buy \| Y Neutral \| Z Sell" |
| `techScoreBar` | Progress bar width reflects score |
| `newsFeedList` | News cards — populated by `app.js` |

### Backtest (Bottom)
| ID | Purpose |
|---|---|
| `backtestCapital` | Input — Initial capital in ₹ (default 500,000) |
| `backtestFee` | Input — Transaction fee % (default 0.05) |
| `runBacktestBtn` | Triggers `app.runBacktest()` |
| `btAiReturn` / `btBhReturn` | AI return vs Buy & Hold |
| `btAlpha` / `btSharpe` / `btMaxDd` / `btWinRate` | Backtest stats |
| `equityCanvas` | Mini equity curve canvas (150px tall) |

### Header Buttons
| ID | Action |
|---|---|
| `syncLiveFeedBtn` | Calls `fetchIndianStockData()` to re-sync |
| `togglePosterModeBtn` | Toggles `body.presentation-mode` class |
| `printPosterBtn` | `window.print()` |

---

## 🎨 css/styles.css — Section Map

| Line range | Section name |
|---|---|
| 1–30 | `:root` CSS custom properties (colors, fonts) |
| 32–45 | Reset (`*`, `body`) |
| 47–123 | **1. Ticker Tape** — `.ticker-tape`, `.pulse-dot`, animation |
| 125–250 | **2. Main Header** — `.main-header`, `.btn`, `.brand-*` |
| 252–509 | **3. Indian Stock Search Bar** — `.search-universe-section`, `.stock-search-input`, `.search-results-dropdown`, `.filter-pill`, `.symbol-tag`, `.exchange-tag`, `.live-feed-sync-btn` |
| 510–575 | **4. Asset Bar** — `.asset-bar`, `.asset-btn` |
| 576–625 | **5. Dashboard Grid** — `.dashboard-grid` (3-col), `.col-left/right/center` |
| 626–705 | **6. Cards & Widgets** — `.card`, `.macro-grid`, `.news-card`, `.prediction-card`, `.signal-pill`, `.probability-split`, `.metrics-grid`, `.feature-bar-item` |
| 706–720 | **7. Bottom Suite** — `.bottom-suite` (single 1fr column now) |
| 721–777 | **8. Backtest Terminal** — `.bt-inputs`, `.bt-stats-grid`, `.bt-stat-box` |
| 778–824 | **9. ~~CSV Dropzone~~** — (styles still present but section removed from HTML) |
| 825–870 | **10. Poster Presentation Mode** — `.poster-only-banner`, `.poster-math-callout`, `body.presentation-mode` overrides |
| 870–876 | **Utility** — `.text-green`, `.text-red`, `.text-cyan`, `.text-muted` |

---

## 📦 js/data.js — Data Layer

### `DEFAULT_ASSETS` — Indian Stock Registry
35 assets defined. All prices in **₹ INR**. Key fields per asset:
```js
{
  symbol, name, sector, exchange, exchangeTag,
  currency: "INR", currencySymbol: "₹",
  basePrice, volatility, drift, sentiment,
  aiRecommendation, analystTarget, category
}
```

**Categories available:** `NIFTY50`, `TECH`, `BANKING`, `AUTO`, `ENERGY`, `DEFENSE`, `PHARMA`, `METALS`, `INFRA`, `INDICES`

**Sample symbols:** RELIANCE, TCS, HDFCBANK, INFY, ICICIBANK, TATAMOTORS, SBIN, BHARTIARTL, ITC, LT, MARUTI, HINDUNILVR, BAJFINANCE, ADANIENT, SUNPHARMA, WIPRO, TITAN, KOTAKBANK, TATASTEEL, POWERGRID, NTPC, AXISBANK, ONGC, COALINDIA, ZOMATO, JIOFIN, HAL, BEL, TRENT, VBL, SUZLON, IRFC, RVNL, CIPLA, DIXON, BSE, NIFTY50, SENSEX, BANKNIFTY

### `INDIAN_STOCKS_METADATA`
Flat array (symbol, name, exchange, sector, basePrice, category) — used by search autocomplete.

### `MACRO_INDICATORS`
RBI Repo Rate, India 10Y G-Sec, India CPI, India VIX, USD/INR — all Indian market data.

### `FINANCIAL_NEWS_FEED`
6 news items — Indian market themed (RBI, Reliance, Tata Motors, HAL/BEL, TCS/Infy, Brent crude).

### `generateHistoricalCandles(symbol, days=220)`
Produces OHLCV candles using GBM + mean reversion. Candle shape: `{ date, dateObj, open, high, low, close, volume, changePercent }`.

### `MARKET_DATABASE`
Populated at load: each symbol in `DEFAULT_ASSETS` gets 200 days of generated candles.

### `fetchIndianStockData(symbol)` — async
1. Checks `MARKET_DATABASE` cache first
2. Tries Yahoo Finance proxy (`<SYM>.NS` then `<SYM>.BO`) via allorigins.win
3. Falls back to `generateHistoricalCandles()` with price calibrated from symbol hash
4. Returns `{ success, source, candles, asset }`

---

## 📊 js/chart.js — Chart Engine

### `FinancialChart` class
| Method | Purpose |
|---|---|
| `constructor(containerId)` | Creates canvas, sets padding `{ top:25, right:85, bottom:30, left:15 }` |
| `initCanvasSize()` | HiDPI-aware resize, resets transform before scaling |
| `bindEvents()` | resize, mousedown/up (drag pan), mousemove, mouseleave, wheel zoom |
| `setData(candles, forecastCone)` | Computes SMA20, SMA50, Bollinger, calls `initCanvasSize()` + `render()` |
| `render()` | Master draw: grid → volume → bollinger → SMA → candles → forecast → crosshair |
| `drawGridAndAxes()` | **Prices labeled as `₹XX.XX`** (right axis) |
| `drawForecastCone()` | 95% → 80% bands + median dashed line + **`₹` target badge** |
| `drawCrosshair()` | **`₹` price tag on Y-axis**, HUD shows `₹O/H/L/C` — right padding 85px wide |

### `RSISubChart` class
| Method | Purpose |
|---|---|
| `constructor(containerId)` | Creates canvas, calls `initSize()` |
| `initSize()` | HiDPI resize, resets transform before scaling |
| `render(candles)` | Calls `initSize()` first, draws RSI(14) purple curve, overbought/oversold zones |

---

## 🤖 js/ml-engine.js — Prediction Engine

### `MLEngine.predict(candles, modelKey, macro, sentiment)`
Returns:
```js
{
  model, currentPrice, isBullish,
  probabilityUp, probabilityDown, confidence,
  signal,            // STRONG BUY / BUY / NEUTRAL / SELL / STRONG SELL
  expectedReturnPercent, targetPrice,
  forecastCone,      // Array of { day, median, upper80, lower80, upper95, lower95 }
  featureImportance, // SHAP bars: RSI / Yield Curve / MACD / ATR(₹) / Sentiment / VIX
  metrics            // { directionalAccuracy, f1, precision, recall, aucRoc, sharpeRatio, maxDrawdown }
}
```
- ATR rawVal formatted as **`₹XX.XX`** (line 132)

### `MLEngine.runBacktest(candles, capital, fee)`
Returns equity curve + `{ totalAiReturn, totalBhReturn, alpha, sharpeRatio, maxDrawdown, winRate, equityCurve }`.

---

## 🎮 js/app.js — AppController

### Constructor state
```js
this.currentSymbol = 'RELIANCE'  // ← update if default asset changes
this.currentModelKey = 'CNN_LSTM'
this.chart, this.rsiChart, this.currentCandles, this.currentPrediction
this.isPresentationMode = false
this.activeFilter = 'ALL'
```

### `init()`
1. Creates `FinancialChart` + `RSISubChart`
2. `bindDomEvents()` → `loadAsset(defaultSymbol)` → `renderMacroWidget()` → `renderNewsFeed()` → `startTickerSimulation()`

### `bindDomEvents()` — event listeners wired
| Trigger | Handler |
|---|---|
| `.asset-btn` click | `loadAsset(symbol)` |
| `#stockSearchInput` input | `handleSearchInput(query)` |
| `#searchResultsDropdown` item click | `loadAsset(symbol)` + close dropdown |
| `#categoryFilterBar .filter-pill` | Filter quick asset bar |
| `#modelSelector` change | `runInferenceAndRender()` |
| overlay checkboxes | update `chart.options.*` + `chart.render()` |
| `#runBacktestBtn` | `runBacktest()` |
| `#syncLiveFeedBtn` | `fetchIndianStockData(currentSymbol)` then reload |
| `#togglePosterModeBtn` | `togglePresentationMode()` |
| `#printPosterBtn` | `window.print()` |

### `loadAsset(symbol)`
- Sets `currentSymbol`, looks up `DEFAULT_ASSETS[symbol]`
- Updates: `currentAssetName`, `currentAssetSymbol`, `currentAssetExchangeTag`, `currentAssetExchange`
- Gets candles from `MARKET_DATABASE` or generates them
- Calls `runInferenceAndRender()` + `runBacktest()`

### `renderPredictionPanel(pred)`
- Price shown as **`₹${pred.currentPrice.toFixed(2)}`**
- Target shown as **`₹${pred.targetPrice}`**

### `renderMacroWidget()`
- Populates `#macroGrid` with Indian macro data (RBI rate, G-Sec yield, CPI, VIX India, USD/INR)

### `handleSearchInput(query)` ← NEW
- Filters `INDIAN_STOCKS_METADATA` against symbol + name + sector (case-insensitive)
- Shows top 8 results + "Search NSE/BSE Live for [query]" prompt
- Keyboard nav: ArrowUp/Down, Enter, Escape

### `startTickerSimulation()`
- Animates `.ticker-val` elements
- Strips `₹` + `,` to parse float; writes back as **`₹${updated.toFixed(2)}`**

---

## 🌐 Currency & Locale

| Location | Format | Status |
|---|---|---|
| Ticker tape (HTML) | `₹X,XXX.XX` | ✅ INR |
| Asset price header | `₹XXXX.XX` (via `renderPredictionPanel`) | ✅ INR |
| Chart Y-axis labels | `₹XX.XX` (`drawGridAndAxes`) | ✅ INR |
| Chart crosshair price | `₹XX.XX` (`drawCrosshair`) | ✅ INR |
| Chart HUD (OHLC) | `₹XX.XX` (`drawCrosshair`) | ✅ INR |
| Forecast cone badge | `AI Target: ₹XXXX` (`drawForecastCone`) | ✅ INR |
| ATR feature importance | `₹XX.XX` (`ml-engine.js:132`) | ✅ INR |
| Backtest capital label | "Initial Capital (₹):" | ✅ INR |

---

## 🔄 Data Flow

```
User types in search
    → handleSearchInput() filters INDIAN_STOCKS_METADATA
    → Dropdown shows results
    → User clicks result
        → loadAsset(symbol)
            → fetchIndianStockData(symbol)   [if live sync]
            → MARKET_DATABASE[symbol]        [cached]
            → generateHistoricalCandles()    [fallback]
            → runInferenceAndRender()
                → MLEngine.predict()
                → chart.setData(candles, forecastCone)
                → rsiChart.render(candles)
                → renderPredictionPanel(pred)
                → renderTechnicalSummary()
            → runBacktest()
                → MLEngine.runBacktest()
                → renderEquityCanvas()
```

---

## ✅ Completed Changes (this session)

- [x] **Quantitative Strategy Backtest Simulator REMOVED**: Entire bottom section deleted from `index.html` and `app.js` per request.
- [x] **Exchange Rates Corrected to Real-Time**: Outdated `₹84.08` replaced with real-time `USD/INR ₹86.85` and `INR/USD $0.0115` with dynamic live fetch via `fetchLiveExchangeRate()` (`open.er-api.com`).
- [x] **TradingView Real-Time Trend Chart Embedded**: Official TradingView widget integrated for all Indian NSE & BSE stocks (`NSE:RELIANCE`, `NSE:TCS`, `BSE:SENSEX`, `NSE:NIFTY50`, etc.) with built-in live RSI(14), MACD, SMA, and BB studies.
- [x] **Real-Time Technical Indicators Input**: Card 2 enhanced to "Real-Time Technical Indicators" with live table displaying RSI(14) (Wilder's smoothed), MACD (12,26,9), SMA 20 vs 50 (Golden/Death Cross), Bollinger Bands, ATR(14) in ₹, and Stochastic %K.
- [x] **Comprehensive Indian Stock Universe Loaded**: `js/nse-bse-stocks.js` integrated with ~170+ listed companies across Large, Mid, Small Cap, and Sectoral indices.
- [x] **Batch File to View in Localhost Created**: `launch_localhost.bat` and `start.bat` created to launch a local server and auto-open `http://localhost:8080` in the browser.
- [x] Currency changed: USD `$` → INR `₹` across all files.
- [x] **Horizontal News Feed (FinBERT Sentiment)**: `renderNewsFeed()` rewritten to populate `#horizontalNewsTrack` with `.hn-card` elements (ticker chips, sentiment pills, scores). Cards are doubled for seamless infinite right→left marquee. Old `#newsFeedList` reference removed.
- [x] **AI Forecast Cone integrated**: `renderIntegratedForecastCone(pred)` method added to `AppController`. Updates `#coneTarget5D`, `#coneBand80`, `#coneBand95`, `#coneDriftVol` from live ML prediction. Draws historical price line + 80%/95% cyan cone bands + median dashed line on `#integratedForecastCanvas` using HiDPI-aware canvas.
- [x] **CSS `.tag-bear` and `.hn-sentiment-pill` variants added**: `styles.css` now includes `.tag-bear { background: rgba(239,68,68,0.15); color: var(--bear-red); }` and all three pill modifier classes (`.hn-sentiment-pill.tag-bull/bear/neutral`).
- [x] **Localhost Server Resiliency (`server.ps1` & `launch_localhost.bat`)**: Standalone `TcpListener`-based static server created (`server.ps1`) to bypass Windows Store Python execution alias and HttpListener sandbox limitations. `launch_localhost.bat` updated to reliably serve `http://localhost:8080/`.
- [x] **Notification Popup Suppression**: TradingView widget popups disabled (`allow_symbol_change: false`, `show_popup_button: false`, `symboledit=0`, `disabled_features: ["header_symbol_search", "symbol_search_hot_key", "popup_hints", "notification_bell"]`), native alerts/prompts suppressed, and autocomplete/autofill popups disabled on `#stockSearchInput`.
- [x] **Real-Time News Feed Expanded & "Streaming Right → Left" Removed**: `FINANCIAL_NEWS_FEED` in `data.js` expanded to 12 authentic Indian market articles covering Banking, Auto, Defense, IT, Energy, and Pharma. The words "Streaming Right → Left" were removed from the header pill in `index.html` and replaced with "LIVE NEWSWIRE".
- [x] **AI ML Tool Percentages Normalized (Thousands → Hundreds)**: Probability split (`#probUpText` and `#probDownText`), directional hit rate (`#metricAccuracy`), and precision (`#metricPrecision`) normalized in `app.js` so values display strictly in standard 0%–100% format (e.g., 78.4% Bullish, 21.6% Bearish, 64.6% Accuracy, 0.69 Precision) instead of 7,840% or 6,460%.

---

## 📐 Layout Dimensions

| Element | CSS class | Width/Height |
|---|---|---|
| Dashboard grid | `.dashboard-grid` | `280px 1fr 340px` (3-col) |
| TradingView widget | `#tradingview_widget_wrapper` | `height: 520px` |
| Master chart (AI mode) | `#masterChartContainer` | `height: 400px` |
| RSI subchart (AI mode) | `#rsiChartContainer` | `height: 110px` |
| Search bar min-width | `.search-bar-wrapper` | `min-width: 300px` |
| Bottom suite | — | **Removed** |

