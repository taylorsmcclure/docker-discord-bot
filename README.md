# docker-discord-bot
This is a containerized version of DiscordBot by chalda.

<p>This version is <strong>only</strong> for arm7 processors such as ones found in Raspberry Pi2s</p>

<h2>Usage:</h2>
<p>You will need to replace the following environment variables in the Dockerfile:</p>
<ul>
<li>S3_BUCKET=Insert your S3 bucket name that holds your auth.json file.</li>
<li>AWS_ACCESS=Insert your AWS_ACCESS key that has S3 GET permissions.</li>
<li>AWS_SECRET=Insert your AWS_SECRET key that has S3 GET permissions.</li>
</ul>

<p>If you do not know how to setup your auth.json file, please refer to chlada's github page for DiscordBot: <a href=https://github.com/chalda/DiscordBot>https://github.com/chalda/DiscordBot</a></p>
