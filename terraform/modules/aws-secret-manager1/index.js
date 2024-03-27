const AWS = require('aws-sdk');

exports.handler = async (event) => {
    const secretId = event.SecretId;

    const client = new AWS.SecretsManager();

    try {
        const data = await client.getSecretValue({ SecretId: secretId }).promise();

        let secretString = data.SecretString;
        if (!secretString) {
            const buff = Buffer.from(data.SecretBinary, 'base64');
            secretString = buff.toString('ascii');
        }

        // Your secret rotation logic here
        // For demonstration purposes, let's just log the retrieved secret
        console.log('Retrieved secret:', secretString);

        return { statusCode: 200, body: JSON.stringify({ message: 'Secret rotated successfully' }) };
    } catch (error) {
        console.error('Error rotating secret:', error);
        throw error;
    }
};

