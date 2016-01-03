Return-path: <Vladimir_Zapolskiy@mentor.com>
Subject: Re: Additional patches in my watchdog-next branch
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Guenter Roeck
	<linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>, Fu Wei
	<fu.wei@linaro.org>
References: <20151228152335.GA18627@roeck-us.net>
 <20151228152710.GA31482@spo001.leaseweb.nl>
 <20151228215709.GA30595@roeck-us.net>
 <20151228225427.GA2018@spo001.leaseweb.nl> <5681C2FE.7070100@mentor.com>
 <20151229071732.GA6292@spo001.leaseweb.nl>
 <20151229160411.GB30405@roeck-us.net>
 <20151229173705.1596cf1d@free-electrons.com>
CC: <linux-watchdog@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <5689A565.1010901@mentor.com>
Date: Mon, 4 Jan 2016 00:49:09 +0200
MIME-Version: 1.0
In-Reply-To: <20151229173705.1596cf1d@free-electrons.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

On 29.12.2015 18:37, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 29 Dec 2015 08:04:11 -0800, Guenter Roeck wrote:
>> Hi Wim,
>>
>> On Tue, Dec 29, 2015 at 08:17:32AM +0100, Wim Van Sebroeck wrote:
>> [ ... ]
>>>
>>> SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.
>>>
>> Absoutely agree.
> 
> Sorry to get into the conversation, but I got interested into the SBSA
> watchdog driver recently, and looked at the status of its merge in the
> kernel.
> 
> I've looked at Fu Wei's v9 from November which I believe is the latest
> version, and then looked at Vladimir's generic pretimeout patch set.
> 
> Vladimir, do you plan to rework the SBSA watchdog driver on top of your
> pretimeout patch series ?

I've looked at v9 ARM SBSA watchdog series and to remove any ambiguity
the proposed pretimeout framework allows to select a taken action on
pretimeout event got from a watchdog device (talking about v9 SBSA series
the hardcoded action is panic, which might be not what a user wants), it
does not add pretimeout handlers though (the kernel already has
WDIOC_SETPRETIMEOUT/WDIOC_GETPRETIMEOUT, and I suppose this mechanism is
going to be reused by the watchdog framework and drivers), so my
pretimeout framework is kind of orthogonal to Fu's changes.

Also for your information in v2 series I've excluded a watchdog
device/driver specific pretimeout handler found in v1:
https://www.spinics.net/lists/linux-watchdog/msg07878.html , if you think
that ARM SBSA watchdog driver may need this, please let me know.

Since there are some noticeable changes in the watchdog framework, I'll
rebase and resend the pretimeout framework for review after the merge
window, please feel free to review/comment on it.

> Or do Fu Wei intends do it ? Alternatively,
> as suggested by Wim and Guenter, submitting an initial version without
> pretimeout support would be a good thing. Are you, or Fu, interested in
> doing this, or should I work at updating Fu's patches in this
> direction ?
> 

--
Best wishes,
Vladimir
