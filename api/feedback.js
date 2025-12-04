// Vercel Serverless Function to handle feedback submissions
// This function receives feedback and sends it via email

export default async function handler(req, res) {
  // Only allow POST requests
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  try {
    const { type, code, status, newCode, reward, source } = req.body;

    // Validate required fields
    if (!type) {
      return res.status(400).json({ error: 'Missing feedback type' });
    }

    // Get email configuration from environment variables
    const RECIPIENT_EMAIL = process.env.RECIPIENT_EMAIL;
    const RESEND_API_KEY = process.env.RESEND_API_KEY;

    if (!RECIPIENT_EMAIL || !RESEND_API_KEY) {
      console.error('Missing email configuration');
      return res.status(500).json({ error: 'Email configuration missing' });
    }

    // Prepare email content based on feedback type
    let subject, htmlContent;

    if (type === 'status') {
      subject = `Code Status Report: ${code}`;
      htmlContent = `
        <h2>📊 Code Status Report</h2>
        <p><strong>Code:</strong> ${code}</p>
        <p><strong>Status:</strong> ${status === 'working' ? '✅ Working' : '❌ Expired'}</p>
        <p><strong>Timestamp:</strong> ${new Date().toLocaleString()}</p>
      `;
    } else if (type === 'newCode') {
      subject = `New Code Submission: ${newCode}`;
      htmlContent = `
        <h2>🆕 New Code Submission</h2>
        <p><strong>Code:</strong> ${newCode}</p>
        <p><strong>Reward:</strong> ${reward || 'Not specified'}</p>
        <p><strong>Source:</strong> ${source || 'Not specified'}</p>
        <p><strong>Timestamp:</strong> ${new Date().toLocaleString()}</p>
      `;
    }

    // Send email using Resend API
    const response = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'Forge Calculator <noreply@forge-calculator.com>',
        to: RECIPIENT_EMAIL,
        subject: subject,
        html: htmlContent
      })
    });

    if (!response.ok) {
      const error = await response.text();
      console.error('Resend API error:', error);
      return res.status(500).json({ error: 'Failed to send email' });
    }

    return res.status(200).json({ 
      success: true, 
      message: 'Feedback submitted successfully' 
    });

  } catch (error) {
    console.error('Error processing feedback:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}
