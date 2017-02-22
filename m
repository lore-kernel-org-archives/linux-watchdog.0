Return-path: <lilja.magnus@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170117083847.ijrvafqjdwduele6@pengutronix.de>
References: <20170117012353.6948-1-vz@mleia.com> <20170117083847.ijrvafqjdwduele6@pengutronix.de>
From: Magnus Lilja <lilja.magnus@gmail.com>
Date: Wed, 22 Feb 2017 20:44:00 +0100
Message-ID: <CAM=E1R5zb4y9HK06C+BiLvY0cfp7YemrV2p6xdxP7DwWkMau1g@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
	Stefan Agner <stefan@agner.ch>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, "# 3 . 18 . x" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

Hi

On 17 January 2017 at 09:38, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Vladimir,
>
> On Tue, Jan 17, 2017 at 03:23:53AM +0200, Vladimir Zapolskiy wrote:
>> Power down counter enable/disable bit switch is located in WMCR register=
,
>> but watchdog controllers found on legacy i.MX21, i.MX27 and i.MX31 SoCs
>> don't have this register. As a result of writing data to the non-existin=
g
>> register on driver probe the SoC hangs up, to fix the problem add more O=
F
>> compatible strings and on this basis get information about availability =
of
>> the WMCR register.
>>
>> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on =
boot")
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Tested-by: Magnus Lilja <lilja.magnus@gmail.com>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>> Changes from v1 to v2:
>> * removed i.MX27 and i.MX31 compatibles from the list, since it is expec=
ted
>>   that their DTB files has a reference to the listed i.MX21 compatible,
>>   many thanks to Uwe Kleine-K=C3=B6nig for the hint,
>> * start the list of compatibles from an i.MX35 specific one, since it is
>>   agreed that i.MX35 precedes i.MX25, thanks to Uwe Kleine-K=C3=B6nig fo=
r review,
>> * added a comment describing any potential changes in future over the li=
st
>>   of watchdog compatible values,
>> * added all collected tags to the commit message.
>>
>> Changes from RFC to v1:
>> * replaced private data struct with a macro as suggested by Guenter,
>
> I didn't see the RFC, but I like a data struct better. It has some
> overhead, but allows for easier expansion later, needs less casting and
> is easier to understand for a reader (see below).
>
>> * updated the comment in the source code to reflect the change,
>> * rearranged and simplified the logic of detecting WMCR presence,
>> * pulled the fix out from the series with optional proposed DTS changes.

So, did we come to an agreement on a patch to be submitted? Perhaps I
missed the info on it being accepted.

Regards, Magnus
