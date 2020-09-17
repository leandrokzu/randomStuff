const Discord = require('discord.js');
const bot = new Discord.Client();
const prefix = "?";
const token = "" //token do bot
const commands = ['wow', 'ah', 'yamete', "an", "happy", "ayaya", "begone", "oof","now the wor", "rapaz", "ratinho", "uepa", "pressao", "double biceps"];

bot.on('message', message => {
    //para ignorar caso a msg seja do proprio bot
    if (message.author.bot) return;
    //para ignorar msg que não tenham o prefixo
    if (!message.content.startsWith(prefix)) return;
    //filtrando o comando para usa-lo no if
    const command = message.content.split("?")[1];

    if (command == "") return;
    //criando mensagem de help
    const helpMessage = new Discord.MessageEmbed()
        .setColor('#0099ff')
        .setTitle('Comandos:')
        .setDescription('Cada comando irá tocar algum som bem doido.')

    commands.forEach(item => {
        helpMessage.addField("?"+item, '\u200B');
    });

    bot.user.setActivity("Sua mãe pela janela");

    var voiceChannel = message.member.voice.channel;
    if (command == 'help') {
        message.channel.send(helpMessage);
    } else if (commands.includes(command)) {
        if (!voiceChannel) {
            return message.channel.send("Aye! Você tem que estar em um canal de voz para usar esse comando.")
        }
        voiceChannel.join().then(connection => {
            connection.play(`./${command}.mp3`);
        }).catch(err => console.log(err));

    } else if (command == 'bye') {
        voiceChannel.leave();
    } else {
        return message.channel.send("Aye! Parece que esse comando não existe, digite ?help para ver os comandos disponíveis.")
    }

});

bot.login(token);