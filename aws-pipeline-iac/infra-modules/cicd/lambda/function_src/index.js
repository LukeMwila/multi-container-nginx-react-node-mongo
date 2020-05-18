const util = require("util"); 
const fetch = util.promisify(util.fetch);

const SLACK_WEBHOOK_URL = '';

const STATUS_GIF = {
  started: 'https://media.giphy.com/media/tXLpxypfSXvUc/giphy.gif',
  succeeded: 'https://media.giphy.com/media/MYDMiSizWs5sjJRHFA/giphy.gif',
  failed: 'https://media.giphy.com/media/d2lcHJTG5Tscg/giphy.gif',
  canceled: 'https://media.giphy.com/media/IzXmRTmKd0if6/giphy.gif',
}

const apiRequest = async (state, pipeline, gif = '') => {
  const response = await fetch(SLACK_WEBHOOK_URL, {
    method: 'post',
    body: JSON.stringify({
      text: `The pipeline ${pipeline} has *${state}*.\n${gif}`
    })
  });

  return response.json();
}

module.exports.handler = async (event, context, callback) => {
  try {
    const { state, pipeline } = event;
    let response;

    switch (state) {
      case 'STARTED':
        response = await apiRequest(state, pipeline, STATUS_GIF.started)
        break;
      case 'SUCCEEDED':
        response = await apiRequest(state, pipeline, STATUS_GIF.succeeded)
        break;
      case 'FAILED':
        response = await apiRequest(state, pipeline, STATUS_GIF.failed)
        break;
      case 'CANCELED':
        response = await apiRequest(state, pipeline, STATUS_GIF.canceled)
        break;
      default:
        response = await apiRequest(state, pipeline)
        break;
    }

    console.log("response:", response);
  }catch(err){
    console.log("error:", err)
  }
}