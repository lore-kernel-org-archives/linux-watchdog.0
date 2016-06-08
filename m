Return-path: <Vladimir_Zapolskiy@mentor.com>
Subject: Re: [PATCH v3 0/6] watchdog: add watchdog pretimeout framework
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160608075619.GF1521@katana>
CC: Wim Van Sebroeck <wim@iguana.be>, Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <57583B4E.1080905@mentor.com>
Date: Wed, 8 Jun 2016 18:35:42 +0300
MIME-Version: 1.0
In-Reply-To: <20160608075619.GF1521@katana>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Wolfram,

On 08.06.2016 10:56, Wolfram Sang wrote:
> 
>> Changes from v2 to v3:
> 
> This series was odd to review. I am used to that we build stuff on top
> of each other to strive for the best technical solution. I didn't expect
> that you like all of my changes, but at least some of them were obviously
> correct. But since even those were ignored, it really feels like a step
> backwards and thus, the reviewing time a bit wasted :(
> 
> Stuff like 64-bit support and the softdog timer (so people can actually
> test the framework) is completely missing, too. Why not adding those?
> They are easy patches.
> 

I don't object or ignore your work, I'm sorry if this series makes you
feel sad, I'll do all my best for you in v4. I'm sincerely happy that
I found one more independent user of the feature, and I appreciate your
done work and review comments, even downloading, applying and adjusting
the changes took your time, and because I'm pretty sure you don't have
much spare time I value it.

Quite many times when I sent long non-trivial series in the past they
were either deterrent for review and plainly ignored or expectedly
caused too many review comments at once, that's why here in the cover
letter I emphasized :

>> In comparison to v1 and v2 this version does not have quite many
>> important features, because now the goal is to initiate technical
>> review of the simplest possible core change, the fat tail is put
>> aside at the moment.

I hope I managed to collect enough review comments (if Guenter adds
a note to your/my comments to v3 4/6, that would be perfect), and I'll
add your new changes and my cut-off changes to v4 pile.

With best wishes,
Vladimir
