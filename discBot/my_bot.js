const Discord = require('discord.js');
const bot = new Discord.Client();


bot.on('message', message => {
    if (message.content == '!Wow') {
        var voiceChannel = message.member.voice.channel;
        voiceChannel.join().then(connection => {

            function play() {
                if (Math.random() * 9 == 3) {
                    connection.play('./wow.mp3');
                    console.log("Aye!");
                }else{
                    console.log(";(");
                }
            }
            setInterval(play, 1800000);

        }).catch(err => console.log(err));
    }
});

bot.on('message', message => {
    if (message.content == '!notWow') {
        var voiceChannel = message.member.voice.channel;
        voiceChannel.leave();
    }
});

bot.login("NzQzNDY0ODY3Njc1MjQyNTc2.XzVDnQ.DAAyql-4B160HSQbTFnXtjR3B2w");