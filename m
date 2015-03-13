Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:15446 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893AbbCMQwd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Mar 2015 12:52:33 -0400
Message-ID: <550315C7.7010403@atmel.com>
Date: Fri, 13 Mar 2015 17:52:23 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"Guenter Roeck" <linux@roeck-us.net>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 02/10] mfd: syscon: Add atmel system timer registers
 definition
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com> <1426162054-9987-3-git-send-email-alexandre.belloni@free-electrons.com> <20150313080315.GC3383@x1> <20150313104032.GG4329@piout.net>
In-Reply-To: <20150313104032.GG4329@piout.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Le 13/03/2015 11:40, Alexandre Belloni a =E9crit :
> Hi,
>=20
> On 13/03/2015 at 08:03:15 +0000, Lee Jones wrote :
>> On Thu, 12 Mar 2015, Alexandre Belloni wrote:
>>
>>> AT91RM920 has a memory range reserved for timer and watchdog config=
uration.
>>> Expose those registers so that drivers can make use of the system t=
imer syscon
>>> declared in at91 DTs.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.=
com>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  include/linux/mfd/syscon/atmel-st.h | 49 +++++++++++++++++++++++++=
++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>  create mode 100644 include/linux/mfd/syscon/atmel-st.h
>>
>> Applied, thanks.

> Actually, I was thinking this could go through the at91 to avoid
> depending on your branch.

Lee,

I was planning to take the whole series with me to limit the number of
merge conflicts and dependencies.
Do you mind if I take this patch with the other AT91 cleanup patches
through the arm-soc tree?
If you are okay, can you remove this patch already applied on your tree=
?

Thanks, bye.
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
