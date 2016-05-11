Return-path: <noltari@gmail.com>
MIME-Version: 1.0
In-Reply-To: <57308B3D.3020502@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk>
	<CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
	<5653612A.4050309@simon.arlott.org.uk>
	<565361AF.20400@simon.arlott.org.uk>
	<70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
	<5654E67A.9060800@gmail.com>
	<5657886F.3090908@simon.arlott.org.uk>
	<alpine.DEB.2.11.1511270926580.3572@nanos>
	<56599D73.7040801@simon.arlott.org.uk>
	<565CE85A.3080904@roeck-us.net>
	<256BE4660FB03085.33070B6A-E0AC-4643-92B8-4FD874210CD9@mail.outlook.com>
	<57308B3D.3020502@roeck-us.net>
Date: Wed, 11 May 2016 08:40:30 +0200
Message-ID: <CAKR-sGcUOskdT=AOWgc4S3zP8AfLR7SrcnEcYK76WX9-k4fzPw@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Florian Fainelli <f.fainelli@gmail.com>, fainelli@broadcom.com
Cc: Simon Arlott <simon@fire.lp0.eu>, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>, Kevin Cernekee <cernekee@gmail.com>,
	MIPS Mailing List <linux-mips@linux-mips.org>, Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Jonas Gorski <jogo@openwrt.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Maxime Bizon <mbizon@freebox.fr>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>
Content-Type: multipart/alternative; boundary=001a1141fc9c620f0505328b51a2
List-ID: <linux-watchdog@vger.kernel.org>

--001a1141fc9c620f0505328b51a2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El lunes, 9 de mayo de 2016, Guenter Roeck <linux@roeck-us.net> escribi=C3=
=B3:

> On 05/09/2016 05:01 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>
>> Hello Guenter,
>>
>> Are there any other issues preventing this patches from being merged?
>>
>>
> My major problem/concern is the interrupt handling and the repeated
> restart of the hardware timer with continuously reduced timeouts.
> This appears fragile, and it doesn't really make sense from a system
> level point of view. Unfortunately, I don't have a data sheet for
> the chip, nor the means or the time to test it myself. So we are pretty
> much in limbo, unless someone from Broadcom confirms that, yes, this is
> the one and expected means to program this watchdog.


As far as I know Florian is now working for Broadcom and he may be able to
give us a hand on this matter :).


>
> Guenter
>
> Regards,
>> =C3=81lvaro.
>>
>> On 11/28/2015 04:26 AM, Simon Arlott wrote:
>>  > Add the BCM6345/BCM6318 timer as an interrupt controller so that it
>> can be
>>  > used by the watchdog to warn that its timer will expire soon.
>>  >
>>  > Support for clocksource/clockevents is not implemented as the timer
>>  > interrupt is not per CPU (except on the BCM6318) and the MIPS clock i=
s
>>  > better. This could be added later if required without changing the
>> device
>>  > tree binding.
>>  >
>>  > Signed-off-by: Simon Arlott <simon@fire.lp0.eu <mailto:
>> simon@fire.lp0.eu>>
>>
>> Hi Simon,
>>
>> can you please re-send the entire series, with all Acked-by:/Reviewed-by=
:
>> tags as appropriate ?
>>
>> Thanks,
>> Guenter
>>
>>
>>
>>
>>
>

--001a1141fc9c620f0505328b51a2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>El lunes, 9 de mayo de 2016, Guenter Roeck &lt;<a href=3D"mailto:li=
nux@roeck-us.net">linux@roeck-us.net</a>&gt; escribi=C3=B3:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On 05/09/2016 05:01 AM, =C3=81lvaro Fern=C3=A1ndez Rojas=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello Guenter,<br>
<br>
Are there any other issues preventing this patches from being merged?<br>
<br>
</blockquote>
<br>
My major problem/concern is the interrupt handling and the repeated<br>
restart of the hardware timer with continuously reduced timeouts.<br>
This appears fragile, and it doesn&#39;t really make sense from a system<br=
>
level point of view. Unfortunately, I don&#39;t have a data sheet for<br>
the chip, nor the means or the time to test it myself. So we are pretty<br>
much in limbo, unless someone from Broadcom confirms that, yes, this is<br>
the one and expected means to program this watchdog.=C2=A0</blockquote><div=
><br></div><div>As far as I know Florian is now working for Broadcom and he=
 may be able to give us a hand on this matter :).</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
Guenter<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Regards,<br>
=C3=81lvaro.<br>
<br>
On 11/28/2015 04:26 AM, Simon Arlott wrote:<br>
=C2=A0&gt; Add the BCM6345/BCM6318 timer as an interrupt controller so that=
 it can be<br>
=C2=A0&gt; used by the watchdog to warn that its timer will expire soon.<br=
>
=C2=A0&gt;<br>
=C2=A0&gt; Support for clocksource/clockevents is not implemented as the ti=
mer<br>
=C2=A0&gt; interrupt is not per CPU (except on the BCM6318) and the MIPS cl=
ock is<br>
=C2=A0&gt; better. This could be added later if required without changing t=
he device<br>
=C2=A0&gt; tree binding.<br>
=C2=A0&gt;<br>
=C2=A0&gt; Signed-off-by: Simon Arlott &lt;<a>simon@fire.lp0.eu</a> &lt;mai=
lto:<a>simon@fire.lp0.eu</a>&gt;&gt;<br>
<br>
Hi Simon,<br>
<br>
can you please re-send the entire series, with all Acked-by:/Reviewed-by:<b=
r>
tags as appropriate ?<br>
<br>
Thanks,<br>
Guenter<br>
<br>
<br>
<br>
<br>
</blockquote>
<br>
</blockquote>

--001a1141fc9c620f0505328b51a2--
