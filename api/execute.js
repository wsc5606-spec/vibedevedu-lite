// Vercel Serverless Function - 코드 실행
const axios = require('axios');

const PISTON_API = 'https://emkc.org/api/v2/piston';

const LANGUAGE_MAP = {
  'python': { lang: 'python', version: '3.10' },
  'javascript': { lang: 'javascript', version: '18.15.0' },
  'typescript': { lang: 'typescript', version: '5.0.3' },
  'java': { lang: 'java', version: '15.0.2' },
  'cpp': { lang: 'c++', version: '10.2.0' },
  'c++': { lang: 'c++', version: '10.2.0' },
  'c': { lang: 'c', version: '10.2.0' },
  'csharp': { lang: 'csharp', version: '6.12.0' },
  'c#': { lang: 'csharp', version: '6.12.0' },
  'go': { lang: 'go', version: '1.16.2' },
  'kotlin': { lang: 'kotlin', version: '1.8.20' },
  'dart': { lang: 'dart', version: '2.19.6' },
  'sql': { lang: 'sqlite3', version: '3.36.0' },
  'html': { lang: 'javascript', version: '18.15.0' },
  'css': { lang: 'javascript', version: '18.15.0' },
};

function getFileExtension(language) {
  const extensions = {
    'python': 'py', 'javascript': 'js', 'typescript': 'ts',
    'java': 'java', 'cpp': 'cpp', 'c++': 'cpp', 'c': 'c',
    'csharp': 'cs', 'c#': 'cs', 'go': 'go', 'kotlin': 'kt',
    'dart': 'dart', 'sql': 'sql', 'html': 'html', 'css': 'css'
  };
  return extensions[language.toLowerCase()] || 'txt';
}

module.exports = async (req, res) => {
  // CORS 헤더
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader('Access-Control-Allow-Headers', 'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version');

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ status: 'error', message: 'Method not allowed' });
  }

  try {
    const { language, code } = req.body;

    if (!language || !code) {
      return res.status(400).json({
        status: 'error',
        message: '언어와 코드를 모두 제공해야 합니다.'
      });
    }

    const langConfig = LANGUAGE_MAP[language.toLowerCase()];
    if (!langConfig) {
      return res.status(400).json({
        status: 'error',
        message: `지원하지 않는 언어입니다: ${language}`
      });
    }

    const startTime = Date.now();

    const pistonResponse = await axios.post(`${PISTON_API}/execute`, {
      language: langConfig.lang,
      version: langConfig.version,
      files: [{
        name: `main.${getFileExtension(language)}`,
        content: code
      }]
    }, {
      timeout: 10000
    });

    const executionTime = Date.now() - startTime;
    const result = pistonResponse.data;

    res.status(200).json({
      status: result.run.code === 0 ? 'ok' : 'error',
      stdout: result.run.stdout || '',
      stderr: result.run.stderr || '',
      exit_code: result.run.code,
      execution_time: `${executionTime}ms`,
      language: langConfig.lang,
      version: langConfig.version
    });

  } catch (error) {
    console.error('Execute error:', error.message);
    res.status(500).json({
      status: 'error',
      message: '코드 실행 중 오류가 발생했습니다.',
      error: error.message,
      stdout: '',
      stderr: error.message,
      exit_code: -1,
      execution_time: '0ms'
    });
  }
};
