export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Only POST allowed" });
  }

  const { username } = req.body;

  const webhook = "https://discord.com/api/webhooks/1395945977361465384/fMeIf8BwOf-VDuiAino5xmguCT8RSPZe4b8sm63DALNV0DJsDLep_EarlZurykZiBFK3";

  try {
    await fetch(webhook, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        content: `🎮 Jogador **${username}** entrou no jogo!`,
      }),
    });

    res.status(200).json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Erro ao enviar para o Discord" });
  }
}
