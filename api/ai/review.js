// Vercel Serverless Function - AI 코드 리뷰 (한글)

function generateMockReview(language, code, execLog) {
  const codeLength = code.trim().split('\n').length;
  const hasComments = code.includes('//') || code.includes('#') || code.includes('/*');
  const isSuccessful = execLog && execLog.exit_code === 0;

  let accuracy = isSuccessful ? 90 + Math.floor(Math.random() * 10) : 50 + Math.floor(Math.random() * 30);
  let efficiency = codeLength < 20 ? 85 + Math.floor(Math.random() * 15) : 70 + Math.floor(Math.random() * 20);
  let readability = hasComments ? 85 + Math.floor(Math.random() * 15) : 65 + Math.floor(Math.random() * 25);

  let feedback = '';
  if (isSuccessful) {
    feedback = '코드가 성공적으로 실행되었습니다! ';
  } else {
    feedback = '코드 실행 중 오류가 발생했습니다. 문법을 다시 확인해보세요. ';
    accuracy = Math.min(accuracy, 70);
  }

  if (codeLength > 50) {
    feedback += '코드가 다소 길어 보입니다. 더 간결하게 작성할 수 있는지 고려해보세요. ';
  } else if (codeLength < 5) {
    feedback += '코드가 매우 간결합니다. ';
  }

  if (hasComments) {
    feedback += '주석이 잘 작성되어 있어 가독성이 좋습니다. ';
  } else {
    feedback += '주석을 추가하면 코드 이해에 도움이 됩니다. ';
  }

  const suggestions = [];

  if (!hasComments) {
    suggestions.push('코드에 주석을 추가하여 각 부분의 목적을 설명하세요.');
  }

  if (isSuccessful) {
    suggestions.push('엣지 케이스(edge cases)를 고려한 테스트를 추가해보세요.');
  } else {
    suggestions.push('오류 메시지를 확인하고 문법을 수정해보세요.');
  }

  if (codeLength > 30) {
    suggestions.push('반복되는 코드를 함수로 분리하여 재사용성을 높이세요.');
  }

  if (language === 'python') {
    suggestions.push('PEP 8 스타일 가이드를 따라 코드를 작성하세요.');
  } else if (language === 'javascript' || language === 'typescript') {
    suggestions.push('const와 let을 적절히 사용하여 변수를 선언하세요.');
  } else if (language === 'java') {
    suggestions.push('Java 네이밍 컨벤션을 따라 클래스와 메서드 이름을 작성하세요.');
  }

  return {
    score: { accuracy, efficiency, readability },
    feedback: feedback.trim(),
    suggestions: suggestions.slice(0, 3)
  };
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
    const { language, code, problemDescription, execLog } = req.body;

    if (!language || !code) {
      return res.status(400).json({
        status: 'error',
        message: '언어와 코드를 모두 제공해야 합니다.'
      });
    }

    const review = generateMockReview(language, code, execLog);

    res.status(200).json({
      status: 'ok',
      review: review
    });

  } catch (error) {
    console.error('AI Review error:', error.message);
    res.status(500).json({
      status: 'error',
      message: 'AI 리뷰 중 오류가 발생했습니다.',
      error: error.message
    });
  }
};
