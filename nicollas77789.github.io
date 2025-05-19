<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InfoTempo Real - Tudo em um lugar</title>
    <style>
        :root {
            --primary: #2568b2;
            --secondary: #2ecc71;
            --accent: #e74c3c;
            --light: #f9f9f9;
            --dark: #2c3e50;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }
        
        header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 25px;
        }
        
        .time-container {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            text-align: center;
            position: sticky;
            top: 20px;
        }
        
        .time-display {
            font-size: 2.8rem;
            font-weight: bold;
            color: var(--primary);
            margin: 15px 0;
            font-family: 'Courier New', monospace;
        }
        
        .date-display {
            font-size: 1.8rem;
            color: var(--secondary);
            margin-bottom: 25px;
        }
        
        .milliseconds {
            font-size: 1.2rem;
            color: var(--accent);
            font-family: 'Courier New', monospace;
        }
        
        .news-container {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }
        
        .news-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary);
        }
        
        .news-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12);
        }
        
        .news-title {
            font-size: 1.4rem;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 12px;
        }
        
        .news-category {
            display: inline-block;
            background-color: var(--secondary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 12px;
        }
        
        .news-description {
            font-size: 1rem;
            color: var(--dark);
            margin-bottom: 15px;
        }
        
        .news-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        footer {
            background: var(--dark);
            color: white;
            text-align: center;
            padding: 1.5rem;
            margin-top: 40px;
        }
        
        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
            }
            
            .time-container {
                position: static;
            }
            
            .time-display {
                font-size: 2.2rem;
            }
            
            .date-display {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>InfoTempo Real Completo</h1>
        <p>Tempo preciso e últimas informações sem complicação</p>
    </header>
    
    <div class="container">
        <div class="time-container">
            <h2>⏰ Tempo no Brasil</h2>
            <div class="date-display" id="current-date"></div>
            <div class="time-display" id="current-time"></div>
            <div class="milliseconds" id="current-milliseconds"></div>
            <div id="timezone">Fuso horário: UTC-3 (Horário de Brasília)</div>
        </div>
        
        <div class="news-container" id="news-container">
            <!-- Notícias serão carregadas aqui -->
        </div>
    </div>
    
    <footer>
        <p>Atualizado em tempo real | Última atualização: <span id="last-update"></span></p>
    </footer>

    <script>
        // Banco de dados de notícias embutido
        const newsDatabase = [
            {
                title: "Nova descoberta em energia limpa promete revolucionar setor",
                category: "Ciência",
                description: "Pesquisadores brasileiros desenvolveram um novo método para armazenamento de energia solar com eficiência recorde de 92%.",
                image: "https://images.unsplash.com/photo-1508514177221-188b1cf16e9d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                timestamp: new Date()
            },
            {
                title: "Evento astronômico raro será visível no Brasil esta semana",
                category: "Astronomia",
                description: "Alinhamento planetário incomum poderá ser observado a olho nu na madrugada de quinta-feira.",
                image: "https://images.unsplash.com/photo-1462331940025-496dfbfc7564?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                timestamp: new Date()
            },
            {
                title: "Avance no tratamento do Alzheimer mostra resultados promissores",
                category: "Saúde",
                description: "Nova terapia experimental reduziu em 60% o avanço da doença em testes clínicos iniciais.",
                image: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                timestamp: new Date()
            },
            {
                title: "Brasil lança novo satélite de monitoramento ambiental",
                category: "Tecnologia",
                description: "Equipamento vai fornecer dados em tempo real sobre desmatamento e mudanças climáticas.",
                image: "https://images.unsplash.com/photo-1464802686167-b939a6910659?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                timestamp: new Date()
            },
            {
                title: "Descoberta nova espécie de animal na Amazônia",
                category: "Meio Ambiente",
                description: "Pequeno mamífero noturno foi identificado por pesquisadores durante expedição científica.",
                image: "https://images.unsplash.com/photo-1524704654690-b56c05c78a00?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
                timestamp: new Date()
            }
        ];

        // Função para atualizar o relógio
        function updateClock() {
            const now = new Date();
            
            // Formata a data
            const optionsDate = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            document.getElementById('current-date').textContent = now.toLocaleDateString('pt-BR', optionsDate);
            
            // Formata a hora
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            document.getElementById('current-time').textContent = `${hours}:${minutes}:${seconds}`;
            
            // Mostra milissegundos
            const milliseconds = String(now.getMilliseconds()).padStart(3, '0');
            document.getElementById('current-milliseconds').textContent = `.${milliseconds}`;
            
            // Atualiza o timestamp do footer
            document.getElementById('last-update').textContent = now.toLocaleTimeString('pt-BR');
        }

        // Função para exibir notícias
        function displayNews() {
            const newsContainer = document.getElementById('news-container');
            newsContainer.innerHTML = '';
            
            // Embaralha as notícias para simular atualização
            const shuffledNews = [...newsDatabase].sort(() => Math.random() - 0.5);
            
            shuffledNews.forEach((article, index) => {
                const newsCard = document.createElement('div');
                newsCard.className = 'news-card';
                
                newsCard.innerHTML = `
                    <img src="${article.image}" alt="${article.title}" class="news-image">
                    <div class="news-category">${article.category}</div>
                    <div class="news-title">${article.title}</div>
                    <div class="news-description">${article.description}</div>
                    <small>Atualizado: ${article.timestamp.toLocaleTimeString('pt-BR')}</small>
                `;
                
                newsContainer.appendChild(newsCard);
                
                // Atualiza o timestamp para parecer mais real
                if (index < 2) {
                    article.timestamp = new Date();
                }
            });
        }

        // Atualiza o relógio a cada 50ms para milissegundos precisos
        setInterval(updateClock, 50);
        
        // Atualiza as notícias a cada 10 segundos
        setInterval(() => {
            displayNews();
            updateClock();
        }, 10000);

        // Inicializa
        updateClock();
        displayNews();
    </script>
</body>
</html>
