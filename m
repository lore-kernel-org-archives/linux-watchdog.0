Return-path: <vz@mleia.com>
From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [RFC PATCH 1/2] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
To: Magnus Lilja <lilja.magnus@gmail.com>, Guenter Roeck <linux@roeck-us.net>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-2-git-send-email-vz@mleia.com>
 <ebece25b-7a3b-3fdf-d117-dd0a3a2975b7@roeck-us.net>
 <CAM=E1R6hzob5ZzyTLmrLL5s-6=vbZQbCig1sLHMSLChJEz9YgA@mail.gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
 Rob Herring <robh+dt@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Message-ID: <0a621c8e-9f75-5951-5f0a-a8e1f62572b7@mleia.com>
Date: Sun, 11 Dec 2016 00:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAM=E1R6hzob5ZzyTLmrLL5s-6=vbZQbCig1sLHMSLChJEz9YgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Magnus,

On 12/10/2016 09:28 PM, Magnus Lilja wrote:
> Hi,
>
> On 26 September 2016 at 15:02, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 09/25/2016 05:39 PM, Vladimir Zapolskiy wrote:
>>>
>>> Power down counter enable/disable bit switch is located in WMCR
>>> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
>>> i.MX31 SoCs don't have this register. As a result of writing data to
>>> the non-existing register on driver probe the SoC hangs up, to fix the
>>> problem add more OF compatible strings and on this basis get
>>> information about availability of the WMCR register.
>>>
>>> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on
>>> boot")
>>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>> ---

[snip]

>
> Has this patch (or an updated one) been merged in any tree? I've
> tested it on a i.MX31 board with positive result.
>

no, it's not in the linux-watchdog repository at the moment, I'm going
to fix Guenter's review comments and send the change today or tomorrow
in hope that it enters v4.10.

Thank you for testing, for your information I'm on the way to send more
i.MX31 changes to get better i.MX31 device tree support.

--
With best wishes,
Vladimir
